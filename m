Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817FC276C40
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 10:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIXIng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 04:43:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:55414 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgIXIng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 04:43:36 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kLMqk-0005cZ-JH; Thu, 24 Sep 2020 10:43:34 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kLMqk-000OLh-E2; Thu, 24 Sep 2020 10:43:34 +0200
Subject: Re: Behavior of pinned perf event array
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <6CAD359B-F446-4C5D-9C71-3902762ED8D6@fb.com>
 <47929B19-E739-4E74-BBB7-B2C0DCC7A7F8@fb.com>
 <0fb36afb-6056-5e44-77d8-1ad57d82db1c@iogearbox.net>
 <BE639CE6-8566-4184-B386-7AEED22939FB@fb.com>
 <fae5ddc7-b7b5-e757-fdbb-2946d56caca3@iogearbox.net>
 <107FC288-D07C-4881-82BD-8FD29CE42290@fb.com>
 <DEBBD27D-188D-4EFD-8C04-838F54689587@fb.com>
 <9E8ACC53-12CD-42B5-8419-2ABDCE5967DA@fb.com>
 <CAEf4BzbDMRzHGyxqXoA+bt_QJvybrjLG1EW9xdYLbDTQ5jLbMA@mail.gmail.com>
 <8AF90C54-22F4-46D3-8D79-A6B002BF3F45@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <374342b3-9504-7ec3-ff73-54cf621c244a@iogearbox.net>
Date:   Thu, 24 Sep 2020 10:43:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8AF90C54-22F4-46D3-8D79-A6B002BF3F45@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25936/Wed Sep 23 15:55:51 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/23/20 6:21 PM, Song Liu wrote:
>> On Sep 14, 2020, at 3:59 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>> On Fri, Sep 11, 2020 at 1:36 PM Song Liu <songliubraving@fb.com> wrote:
[...]
>> Daniel, are you aware of any use cases that do rely on such a behavior
>> of PERV_EVENT_ARRAY?
>>
>> For me this auto-removal of elements on closing *one of a few*
>> PERF_EVENT_ARRAY FDs (original one, but still just one of a few active
>> ones) was extremely surprising. It doesn't follow what we do for any
>> other BPF map, as far as I can tell. E.g., think about
>> BPF_MAP_TYPE_PROG_ARRAY. If we pin it in BPF FS and close FD, it won't
>> auto-remove all the tail call programs, right? There is exactly the
>> same concern with not auto-releasing bpf_progs, just like with
>> perf_event. But it's not accidental, if you are pinning a BPF map, you
>> know what you are doing (at least we have to assume so :).
>>
>> So instead of adding an extra option, shouldn't we just fix this
>> behavior instead and make it the same across all BPF maps that hold
>> kernel resources?
> 
> Could you please share your thoughts on this? I personally don't have
> strong preference one way (add a flag) or the other (change the default
> behavior). But I think we need to agree on the direction to go.

My preference would be to have an opt-in flag, we do rely on the auto-removal
of the perf event map entry on client close in Cilium at least, e.g. a monitor
application can insert itself into the map to start receiving events from
the BPF datapath, and upon exit (no matter whether graceful or not) we don't
consume any more cycles in the data path than necessary for events, and
from the __bpf_perf_event_output() we bail out right after checking the
READ_ONCE(array->ptrs[index]) instead of pushing data that later on no-one
picks up.
