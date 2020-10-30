Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28022A0F35
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 21:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgJ3UIA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgJ3UH6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 16:07:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0ADC0613CF;
        Fri, 30 Oct 2020 13:07:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k125so3272630wmf.0;
        Fri, 30 Oct 2020 13:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FpCslJZ/vqty4l/vz2YpbZGTlDZJ7cQIaDs0z8MBb9Q=;
        b=YcN9bdquotAjnrthfpW3IwHIEkgx6h42SlkjKXvr0CpceHRxdmjmaYllQhz0bPMBZt
         3icp020XsDQDBucbMTtt1SU6D/cUzNLj1NRRgq8OKrrZCDmSBnhhJcGGWoLyYP/5AtoJ
         XlnMFNSB4iOVvfOQ16M14Dd8tGmwatI/40hvL8dPt7tuMQAURvwDrISXwJgwyBzhXfbg
         XzLdvwZP+9ZhFYrcn+lKV0mwT63/XGHADrurSBn6/tQg0CPWeJcMklmELuSNJ/RBT/+S
         MEZRpvWfuwB3oCbxo8nlbfgbaqv8p+IF4/SA+AqrZB1jyW1tt3hVIbzxQLqEB/4VA4Kq
         8/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FpCslJZ/vqty4l/vz2YpbZGTlDZJ7cQIaDs0z8MBb9Q=;
        b=kG+HnApDrJFT2XSNYMYv67us0iTxpcqJ0MJtdeTdwsHqrej8Z0Ie97iC1s0e5QXKBM
         XHWgAA6BjXGrxmAaUC2rCv2H/k+F/Hy/Q9r1jsyhejoLDcUKF2MdaCobJls3vRBmeRKK
         d3RoLMbU2eMNgwaBg1hgyyBurDQTR76ZV+otPZhnzQKO4FSWVzrKNWV9lgfOuWopWP6i
         Xu5eK7O6tfY1Xoef8xuBRCDQrLSU+GUbRfT6fzrPA7/fgV75wXuImSiw2FHy5zPUuzci
         IFspwPuPR914K91/XV+Uiiw7l/dA7uQkiaZmaAnWkCoQqH6cmjrpbyZdy/6zXw5U/8yK
         c6XQ==
X-Gm-Message-State: AOAM530gloPcfLV5FXEj3A4uR+IOkSUrmUdXvYvkLs+nDanFRjWU8XBk
        dzq6C4RKhhGHKo1SJyLmCCI=
X-Google-Smtp-Source: ABdhPJztQtotCRmX3fj5tBmhKO5lYUgAvoZG+N03iU1161n3w8ULxgpWHp87pzLrq1ac+M8i05ZZQQ==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr4614649wmb.54.1604088476501;
        Fri, 30 Oct 2020 13:07:56 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id j9sm11929205wrp.59.2020.10.30.13.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 13:07:55 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        Christian Brauner <christian.brauner@canonical.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-man <linux-man@vger.kernel.org>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     Jann Horn <jannh@google.com>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <20201029152609.k3urvzjocf3s7uml@gmail.com>
 <91b74ce1-de95-2b92-c62e-e2715d6071d3@gmail.com>
 <CAG48ez0TZrwBoEi4d6n+FUN19hq6Pc+DOGNrRb-zHDSZVm9kfw@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <f610cecf-d824-3501-e188-357efd9b1c76@gmail.com>
Date:   Fri, 30 Oct 2020 21:07:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez0TZrwBoEi4d6n+FUN19hq6Pc+DOGNrRb-zHDSZVm9kfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/30/20 8:24 PM, Jann Horn wrote:
> On Thu, Oct 29, 2020 at 8:53 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>> On 10/29/20 4:26 PM, Christian Brauner wrote:
>>> I like this manpage. I think this is the most comprehensive explanation
>>> of any seccomp feature
>>
>> Thanks (at least, I think so...)
>>
>>> and somewhat understandable.
>>       ^^^^^^^^
>>
>> (... but I'm not sure ;-).)
> 
> Relevant: http://tinefetz.net/files/gimgs/78_78_17.jpg

Perfekt :-).


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
