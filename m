Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CF2E2BCF
	for <lists+bpf@lfdr.de>; Fri, 25 Dec 2020 16:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgLYO6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Dec 2020 09:58:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbgLYO6O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Dec 2020 09:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608908207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h67Ik1L4EFeN6xNYPE5yqVkOkBhTnSq5wIBHrTpEQ/g=;
        b=CaUDaf0nMixV6zcTS1qRdbtwiCT3iDcy23VjrpAnXD7CuJImuvYHL94SQsJdZ1RniSrrma
        I5e/BkKyO8GhBPDOzrMIYSnBSnkBPeTHTRBcuT9aOKyssaf3c/w0EAtzFtla36RbBtKKz6
        bS7LhTO5j28K+RdXqJpTQgkB9p6IuDQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-cDWSWOgMNNKI3oCcVIUgYQ-1; Fri, 25 Dec 2020 09:56:45 -0500
X-MC-Unique: cDWSWOgMNNKI3oCcVIUgYQ-1
Received: by mail-oo1-f70.google.com with SMTP id m7so1989026oop.18
        for <bpf@vger.kernel.org>; Fri, 25 Dec 2020 06:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=h67Ik1L4EFeN6xNYPE5yqVkOkBhTnSq5wIBHrTpEQ/g=;
        b=Uys+eJQ4lHWGDxnweUFCmumGn51Gb3X/RmRiQBxLXapntvUo5kgOOrnaLdYynYMg/g
         CldY91CZqQf9d0Ps4nxPa3x0Kn3IVy+ZbxP6bdOLkWErvQrRFLzFUpSVugOhZSOo2lPv
         uXm5VInsscEQmxF8lPti4ttL1xu/JyLQ8KFo6DBZbvHuXt0ejefbAu+t6EValaKhEdKE
         S+57xxu5xyqv9QRYjHr96O4SS9YrNIac1KMDtawqdwALWOn8S27pNiiy280BmkBrYmLF
         NyzxFLR5wMzRj9c9a2IcV1jTmHtMvdIetPKpr8fVbUn7mDYCeZA7Mhdy0EJThd9sFYM0
         9oLw==
X-Gm-Message-State: AOAM5307hu+0SNbDAsux9YuTy8oSsdILzdUl6CNpIZcZ+HBgrWYHjdSu
        jrvJmKE7ECwouSQ2GUyT1brl6bpSGtJ9XGi5DrLE00RVPTGAnJs6735+/FsQrybPuxOG8gw0eg3
        w2c1qlUIQHbMB
X-Received: by 2002:a05:6808:148:: with SMTP id h8mr5521660oie.10.1608908204722;
        Fri, 25 Dec 2020 06:56:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2QlzbWDcBFNn++yW7Xiy4zYIJEj/pqT2gvxb+VW6ALnn1r0RllmCbZ7v3Vh3jzXzhWihxAg==
X-Received: by 2002:a05:6808:148:: with SMTP id h8mr5521637oie.10.1608908204539;
        Fri, 25 Dec 2020 06:56:44 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j126sm3841502oif.8.2020.12.25.06.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Dec 2020 06:56:43 -0800 (PST)
Subject: Re: [PATCH] nfp: remove h from printk format specifier
To:     Joe Perches <joe@perches.com>,
        Simon Horman <simon.horman@netronome.com>
Cc:     kuba@kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, gustavoars@kernel.org,
        louis.peens@netronome.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com,
        linux-kernel@vger.kernel.org
References: <20201223202053.131157-1-trix@redhat.com>
 <20201224202152.GA3380@netronome.com>
 <bac92bab-243b-ca48-647c-dad5688fa060@redhat.com>
 <18c81854639aa21e76c8b26cc3e7999b0428cc4e.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7b5517e6-41a9-cc7f-f42f-8ef449f3898e@redhat.com>
Date:   Fri, 25 Dec 2020 06:56:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <18c81854639aa21e76c8b26cc3e7999b0428cc4e.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 12/24/20 2:39 PM, Joe Perches wrote:
> On Thu, 2020-12-24 at 14:14 -0800, Tom Rix wrote:
>> On 12/24/20 12:21 PM, Simon Horman wrote:
>>> On Wed, Dec 23, 2020 at 12:20:53PM -0800, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> This change fixes the checkpatch warning described in this commit
>>>> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")
>>>>
>>>> Standard integer promotion is already done and %hx and %hhx is useless
>>>> so do not encourage the use of %hh[xudi] or %h[xudi].
>>>>
>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> Hi Tom,
>>>
>>> This patch looks appropriate for net-next, which is currently closed.
>>>
>>> The changes look fine, but I'm curious to know if its intentionally that
>>> the following was left alone in ethernet/netronome/nfp/nfp_net_ethtool.c:nfp_net_get_nspinfo()
>>>
>>> 	snprintf(version, ETHTOOL_FWVERS_LEN, "%hu.%hu"
>> I am limiting changes to logging functions, what is roughly in checkpatch.
>>
>> I can add this snprintf in if you want.
> I'm a bit confused here Tom.
>
> I thought your clang-tidy script was looking for anything marked with
> __printf() that is using %h[idux] or %hh[idux].
Yes, it uses the format attribute to find the logging functions.
>
> Wouldn't snprintf qualify for this already?
>
> include/linux/kernel.h-extern __printf(3, 4)
> include/linux/kernel.h:int snprintf(char *buf, size_t size, const char *fmt, ...);

Yes, this is found.

But since snprintf is not really a logging function, I ignore these.

If someone asks for them not to be ignored in a specific change, I will do that.

>
> Kernel code doesn't use a signed char or short with %hx or %hu very often
> but in case you didn't already know, any signed char/short emitted with
> anything like %hx or %hu needs to be left alone as sign extension occurs so:

Yes, this would also effect checkpatch.

Tom

>
> 	signed char foo = -1;
> 	printk("%hx", foo);
>
> emits ffff but
>
> 	printk("%x", foo);
>
> emits ffffffff
>
> An example:
>
> $ gcc -x c -
> #include <stdio.h>
> #include <stdlib.h>
>
> int main(int argc, char **argv)
> {
> 	signed short i = -1;
> 	printf("hx: %hx\n", i);
> 	printf("x:  %x\n", i);
> 	printf("hu: %hu\n", i);
> 	printf("u:  %u\n", i);
> 	return 0;
> }
>
> $ ./a.out
> hx: ffff
> x:  ffffffff
> hu: 65535
> u:  4294967295
>
> $
>
>

