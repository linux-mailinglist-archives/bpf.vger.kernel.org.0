Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778C63CE70E
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 19:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349843AbhGSQUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352970AbhGSQP1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 12:15:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D2C05BD19
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 09:19:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t2so24467536edd.13
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9A4M3ADvk7EV6HHVkruyfGQ98OoMyTb7LiTD7D3LQUw=;
        b=oB+drgxHcgASSQyas3ohVagZMsnXfdKrmLEdCkyzjKqlAaOW+pgKYxeqcLUH5XbA7N
         ZQZW0U33rumaUfZiMxP4xfsTgwfuXyZMVHOL/NqrqzWpglbV1wih2kUWPAuizdZDyrmK
         ufBavPSXfC5qo0r9t15HUaRhSIOqQrPCxptdmSpiOqbDjqCn5zKyN3z/1e8dz3bfeNAg
         xfjwi7DL1x3pyvnNfnuhBh0nmRpfZOuzaXZwxOsKH0+QyRQkR/RzL4Zp6XbVuFOBPdaE
         b5ccq1rR5ySsNNdjyfL9HbICBDvlsKMDhlyPKv/CjXTTeG8rVSiO88n44f0GnDFNdAmT
         XYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9A4M3ADvk7EV6HHVkruyfGQ98OoMyTb7LiTD7D3LQUw=;
        b=O/oLtqjXcFwt20i0HmLQpSENDL3xw0ISIbhkJsX1dW/2TkxMsnzv6d98KVK9c3i/rw
         xJEGLXt+aljCG3nbP1O0XLOaw3/DU859UcmHL24qwgtnev3wNBu2ZDKSp2OMZUmgdcMG
         rn2r7CxF/UApAR6qGhZ2Zzj7xpgOmQnZPxsLgn5sKPtL61xCF6s31zorG0GmJN7Vm7Md
         Pd7sRTM52IeRZz5+oTijPh8heDksLSXAaQlOBSfrcS5/DiestvqBxBRDHCwLfCh/taLb
         o/gfPaPNsTh5kNXum1QzUJ1W0R0Uo/H10kXtQEDv4oADBPI3Rn+wuyf7kpgH0+kngcEM
         HEZQ==
X-Gm-Message-State: AOAM531XIjOKDJzmVTSQOANyi5eyyYpQI/5yXaMi9MGot0MDT0/pdXXX
        TLwJc5S05uB1hpnejkzjrNc=
X-Google-Smtp-Source: ABdhPJxcvanz+RIzhP5NXUl88IuY/owl3ZhawfQhp241GW1bQgPxB4mc4bzp1Fb/Frm0J1iKa0IZVg==
X-Received: by 2002:a05:6402:2317:: with SMTP id l23mr35384526eda.265.1626712925954;
        Mon, 19 Jul 2021 09:42:05 -0700 (PDT)
Received: from [192.168.2.75] (host-95-232-75-128.retail.telecomitalia.it. [95.232.75.128])
        by smtp.gmail.com with ESMTPSA id k13sm7922102edi.65.2021.07.19.09.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 09:42:05 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] tools/lib/bpf: bpf_program__insns allow to
 retrieve insns in libbpf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
 <CAEf4BzaMcWGt+eqEqQdpJ_s5Zv80ziCA+vo5fa5HmaZmwBvh6A@mail.gmail.com>
 <CAADnVQKH2ViNN6QQJR3Fzo2+k+GmVu=nwAREPjuLZ6_HS8-XMg@mail.gmail.com>
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
Message-ID: <8745074b-a4e5-14a0-721f-140d9d4864b7@gmail.com>
Date:   Mon, 19 Jul 2021 18:42:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQKH2ViNN6QQJR3Fzo2+k+GmVu=nwAREPjuLZ6_HS8-XMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/16/21 3:51 AM, Alexei Starovoitov wrote:
> On Thu, Jul 15, 2021 at 2:40 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Tue, Jul 13, 2021 at 11:34 AM Lorenzo Fontana
>> <fontanalorenz@gmail.com> wrote:
>>> This allows consumers of libbpf to iterate trough the insns
>>> of a program without loading it first directly after the ELF parsing.
>>>
>>> Being able to do that is useful to create tooling that can show
>>> the structure of a BPF program using libbpf without having to
>>> parse the ELF separately.
>>>
>> So I wonder how useful is getting raw BPF instructions before libbpf
>> processed them and resolved map references, subprogram calls, etc?
>> You'll have lots of zeroes or meaningless constants in ldimm64
>> instructions, etc. I always felt that being able to get instructions
>> after libbpf processed them is more useful. The problem is that
>> currently libbpf frees prog->insns after successful bpf_program__load.
>> There is one extra (advanced) scenario where having those instructions
>> preserved after load would be really nice -- cloning BPF program (I
>> had use case for fentry/fexit). So the question is whether we should
>> just leave those prog->insns around until the object is closed or not?
>> And if we do, should bpftool dump instructions before or after load?
>> Let's see what folks think.
> Same here. I understand the desire, but the approach to expose half baked
> instructions isn't addressing the need.

Thanks taking the time to go trough this and understanding the use case.
You all certainly know the scope of this better than I do.
I'll study a bit more to understand how that can be achieved and try to send another patch if I find a solution.
