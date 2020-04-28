Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD31BCC85
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 21:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgD1Tkd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 15:40:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:38640 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgD1Tkd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 15:40:33 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jTW5n-00034R-Kg; Tue, 28 Apr 2020 21:40:31 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jTW5n-000LDn-Cz; Tue, 28 Apr 2020 21:40:31 +0200
Subject: Re: [PATCH v2] selftests/bpf: Copy runqslower to OUTPUT directory
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20200428173742.2988395-1-vkabatov@redhat.com>
 <CAEf4Bzbp44pnj-yNP61enxh8-ZvFn56fSF4uDHLz0ZcY-H2yAA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8e07a2db-a258-f1b3-d1f4-74f131cbcb6d@iogearbox.net>
Date:   Tue, 28 Apr 2020 21:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzbp44pnj-yNP61enxh8-ZvFn56fSF4uDHLz0ZcY-H2yAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25796/Tue Apr 28 14:00:48 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/28/20 8:57 PM, Andrii Nakryiko wrote:
> On Tue, Apr 28, 2020 at 10:38 AM Veronika Kabatova <vkabatov@redhat.com> wrote:
>>
>> $(OUTPUT)/runqslower makefile target doesn't actually create runqslower
>> binary in the $(OUTPUT) directory. As lib.mk expects all
>> TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
>> the OUTPUT directory, this results in an error when running e.g. `make
>> install`:
>>
>> rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
>>         such file or directory (2)
>>
>> Copy the binary into the OUTPUT directory after building it to fix the
>> error.
>>
>> Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")
>> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
>> ---
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
