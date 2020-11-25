Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926E12C3FBC
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 13:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgKYMR3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 07:17:29 -0500
Received: from www62.your-server.de ([213.133.104.62]:55572 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKYMR3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 07:17:29 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1khtjg-0000rR-7u; Wed, 25 Nov 2020 13:17:24 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1khtjf-000F3v-WF; Wed, 25 Nov 2020 13:17:24 +0100
Subject: Re: [PATCH bpf-next v3 1/3] ima: Implement ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>, Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-2-kpsingh@chromium.org>
 <3b6f7023-e1fe-b79b-fa06-b8edcce530de@fb.com>
 <CACYkzJ51imU+_iNR3zG2pzqvVoewSE+NCTJo_V5ZGYJOej-B-g@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0a627bb2-b356-0141-5e5a-b82d56d0de70@iogearbox.net>
Date:   Wed, 25 Nov 2020 13:17:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACYkzJ51imU+_iNR3zG2pzqvVoewSE+NCTJo_V5ZGYJOej-B-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25998/Tue Nov 24 14:16:50 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/25/20 1:04 PM, KP Singh wrote:
> On Tue, Nov 24, 2020 at 6:35 PM Yonghong Song <yhs@fb.com> wrote:
>> On 11/24/20 7:12 AM, KP Singh wrote:
>>> From: KP Singh <kpsingh@google.com>
>>>
>>> This is in preparation to add a helper for BPF LSM programs to use
>>> IMA hashes when attached to LSM hooks. There are LSM hooks like
>>> inode_unlink which do not have a struct file * argument and cannot
>>> use the existing ima_file_hash API.
>>>
>>> An inode based API is, therefore, useful in LSM based detections like an
>>> executable trying to delete itself which rely on the inode_unlink LSM
>>> hook.
>>>
>>> Moreover, the ima_file_hash function does nothing with the struct file
>>> pointer apart from calling file_inode on it and converting it to an
>>> inode.
>>>
>>> Signed-off-by: KP Singh <kpsingh@google.com>
>>
>> There is no change for this patch compared to previous version,
>> so you can carry my Ack.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
> 
> I am guessing:
> 
> *  We need an Ack from Mimi/James.

Yes.

> * As regards to which tree, I guess bpf-next would be better since the
> BPF helper and the selftest depends on it

Yep, bpf-next is my preference as otherwise we're running into unnecessary
merge conflicts.

Thanks,
Daniel
