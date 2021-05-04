Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44524373146
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhEDURV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 16:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhEDURV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 16:17:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C4C061574;
        Tue,  4 May 2021 13:16:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v12so10725939wrq.6;
        Tue, 04 May 2021 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Op37xX+0qr4bnMuSBrGHW+sAMoQGBPFehE3Xd/Y0kxY=;
        b=D8V03oEDsfYNEqDBAECbgTTb+d4smUE9oPx4+tg7wkXn4bbqgb46iVwjNAydfQsza0
         isQIg8R6TXJRfOS2t2EKOGKjpIx0UdSDnZOggoHdva5wnnLp5tJtW/I/qyTA8SZP812q
         L8SHDi+R0OgqrCuR+bFpgKJCQcmdlAlgeEKEDqeL9fe8+e0Bgf4aXELX8fzkF1RdYHmi
         QnzF/7cnUPKjkij/6hPXCgPLQWLP9beo5Mtqm4UFLm4ncRahq/96eQIxbBLxnc1p878m
         wRNF0lr41vVlUne2EcnE/QlyRzR9GeRJ/bBjSJ5QBpfr77md9ret/eUtoN2lTABda6hG
         v4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Op37xX+0qr4bnMuSBrGHW+sAMoQGBPFehE3Xd/Y0kxY=;
        b=hCb+dME7tmGfGI6ycEPyLMrwaaEYSGDGDyiCwpxOlI2e3TPA7amdb7pW9nBoqJ2iSE
         fVif9o4XNR98Dzp8NPZDuZTCHeT/edQGcKOBpCmqqxku+eGyKkjc1etKS4vrdwL6l2Bz
         QjF79e4HwnoaZdhl+cYBCkIVNThGqmpkW/m+SfDf45JYtGurbtvaAoSRM6jvWCvDYfnL
         0fCrlkuPhbZGSKnOypZrnE3l82h1PuZxyv72aOEQ0lxWNm5RARV1yUDL3SKq8mmbjE7Z
         HQYwA47x6bNUfv0WtHrfaXQ12Vmjv9VEbjZswKqDTVr/prDgNRA1YW/E3xYKC9oQfs6h
         HNXA==
X-Gm-Message-State: AOAM531mhT1ZY+MYGcZxclBU7tJbvA/2llNFF1wCmfDMdon2ORm1E2B4
        m3BNZcpPiho1KlbkzRq5U84=
X-Google-Smtp-Source: ABdhPJzjo2nvwoKSLuOCYKx7qg/CdUVtVfCTMxkqk1rM/AbzglelIjJNIGtqsictc0r8+I64cOQu0Q==
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr34194176wrs.5.1620159384629;
        Tue, 04 May 2021 13:16:24 -0700 (PDT)
Received: from [192.168.0.237] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id i11sm17133658wrp.56.2021.05.04.13.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:16:24 -0700 (PDT)
Subject: Re: [RFC v2] bpf.2: Use standard types and attributes
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        Joseph Myers <joseph@codesourcery.com>,
        David Laight <David.Laight@aculab.com>, davem@davemloft.net
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20210504110519.16097-1-alx.manpages@gmail.com>
 <CAADnVQLdW=jH1CUP02jokEu3Sh+=xKsCXvjA19kfz7KOn9mzkA@mail.gmail.com>
 <YJFZHW2afbAMVOmE@kroah.com> <69fb22e0-84bd-47fb-35b5-537a7d39c692@gmail.com>
 <YJFxArfp8wN3ILJb@kroah.com>
 <CAKCAbMg_eRCsD-HYmryL8XEuZcaM1Qdfp4XD85QKT6To+h3QcQ@mail.gmail.com>
 <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
 <8a184afe-14b7-ed15-eb6a-960ea05251d1@iogearbox.net>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <6ad5b5e3-1f9b-2302-84e5-8141d95fc142@gmail.com>
Date:   Tue, 4 May 2021 22:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8a184afe-14b7-ed15-eb6a-960ea05251d1@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On 5/4/21 10:06 PM, Daniel Borkmann wrote:
>>
>> On 5/4/21 6:08 PM, Daniel Borkmann wrote:
>>  >
>>  > But what /problem/ is this really solving? Why bother to change 
>> this /now/
>>  > after so many years?! I think this is causing more confusion than 
>> solving
>>  > anything, really. Moreover, what are you doing with all the
>>  > __{le,be}{16,32,64}
>>  > types in uapi? Anyway, NAK for bpf.2 specifically, and the idea 
>> generally..
>>
>> I'm trying to clarify the manual pages as much as possible, by using 
>> standard conventions and similar structure all around the pages.  Not 
>> everyone understands kernel conventions.  Basically, Zack said very 
>> much what I had in mind with this patch.
> 
> But then are you also converting, for example, __{le,be}{16,32,64} to plain
> uint{16,32,64}_t in the man pages and thus removing contextual information
> (or inventing new equivalent types)?
> 
> What about other types exposed to user space like __sum16, __wsum, or 
> __poll_t
> when they are part of a man page, etc?

Sorry, I forgot to address that part in my answer.  If there's no 
standard way of naming a type without losing information, we can use the 
kernel naming.  I have no objection to that.

These are the only pages that seem to be using those:

$ grep -Enr '\b__[a-z][a-z]+[0-9]+' man?
man2/clone.2:44:clone, __clone2, clone3 \- create a child process
man2/clone.2:1694:.BI "int __clone2(int (*" "fn" ")(void *),"
man2/clone.2:1717:.BR __clone2 ()
man7/sock_diag.7:362:    __be16  idiag_sport;
man7/sock_diag.7:363:    __be16  idiag_dport;
man7/sock_diag.7:364:    __be32  idiag_src[4];
man7/sock_diag.7:365:    __be32  idiag_dst[4];
man7/bpf-helpers.7:514:.B \fBlong bpf_skb_vlan_push(struct sk_buff 
*\fP\fIskb\fP\fB, __be16\fP \fIvlan_proto\fP\fB, u16\fP 
\fIvlan_tci\fP\fB)\fP
man7/bpf-helpers.7:878:.B \fBs64 bpf_csum_diff(__be32 *\fP\fIfrom\fP\fB, 
u32\fP \fIfrom_size\fP\fB, __be32 *\fP\fIto\fP\fB, u32\fP 
\fIto_size\fP\fB, __wsum\fP \fIseed\fP\fB)\fP
man7/bpf-helpers.7:949:.B \fBlong bpf_skb_change_proto(struct sk_buff 
*\fP\fIskb\fP\fB, __be16\fP \fIproto\fP\fB, u64\fP \fIflags\fP\fB)\fP
man7/system_data_types.7:473:.I __int128
man7/system_data_types.7:475:.I __int128
man7/system_data_types.7:1584:.I unsigned __int128
man7/system_data_types.7:1586:.I unsigned __int128
$

So sock_diag.7 and bpf-helpers.7 and only a handful of cases. Not much 
of a problem.  I'd keep those untouched.

Regards,

Alex



-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
