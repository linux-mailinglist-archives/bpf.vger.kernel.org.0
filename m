Return-Path: <bpf+bounces-9198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF23791AA7
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619681C20852
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653AC2C0;
	Mon,  4 Sep 2023 15:30:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931A3D8B
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 15:30:47 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0462CC3
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 08:30:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf48546ccfso5784625ad.2
        for <bpf@vger.kernel.org>; Mon, 04 Sep 2023 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693841445; x=1694446245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSFqS3OJgqzIVK5qBVeLmZyOzEN80QkZMdWeV2jIe18=;
        b=CeRihG6bACRTQtypXbRQJUPYCvorrXJxNUPnY2c6yXJ8f6o4XZL+WsU3qNdb81zJde
         LZTTZ3bAPQbi8tKOcqosoHCxZsT6fgHl5SbLaHd7r9wA6BXssW6D0N2IYRFl8iJG4F+p
         QRAdGRFT4k1Dms6rjsbibkC8MXAc9pIQ5+axWR5CVX94myXK00BxA4MLpkptYTU1QvBy
         Z2MzmiVhcHX2kohvWF4Y6Acky+odKOSE1YpRWV6JW3k/Xqlgcl1mhlh9axK2HWbdKtZU
         9PVv2qBoWHBqoTUwO/HR2K0ETME4NBL8o6CVt9rL1osz4mkuY7Z/zy7VGkmsqWZCc4AB
         pLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693841445; x=1694446245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSFqS3OJgqzIVK5qBVeLmZyOzEN80QkZMdWeV2jIe18=;
        b=X8ivt6ftGNw67XAp4HB3Ij4n4lNCUso2vUrAc2bfZFAlR+wlcLKd0iyna36O+o+qXJ
         mm0bRZgQdY7fHy7FisjqZ41WdSuYP8o0PeecZtaSyRQ2fX4ESm2SPiFF3vvVYJw+4wze
         +c57Aaf4hArrJmg1kZeR5UBUBQ2m96bsTc2jmQpjzklzq/A1lyoXaEXeM8sAja56Yl9r
         aGApVs13e7ezomWxYVC1viUkUGE6nGWcbj1L+LN95+fu72XvznXUddQ447o3YBhqXqVb
         KzmDxseNfGNB2Px+HCDtCVsXxPYrbSsnRofDNF6HpSoABAMrQnU1ng5dJ+/rjzwIdt+z
         2X1Q==
X-Gm-Message-State: AOJu0YwDcj1Vp8Pp3Ooj1JAw8kEe9Y1fh5wu7l44QnBMj3vpGhYmNTYB
	pOr034vVIqfpCkGrudMaUw8=
X-Google-Smtp-Source: AGHT+IHVvzA7WXQ9X9oByVLOouwF29Y2moCjSBMb4vM14aoxsBRBGYSp3R37CwsQZu0LOC7FL1x2cQ==
X-Received: by 2002:a17:902:d48f:b0:1c2:1068:1f54 with SMTP id c15-20020a170902d48f00b001c210681f54mr9537091plg.38.1693841445150;
        Mon, 04 Sep 2023 08:30:45 -0700 (PDT)
Received: from ?IPV6:2409:895a:38a8:67b4:64fa:756f:cff2:929a? ([2409:895a:38a8:67b4:64fa:756f:cff2:929a])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001bde440e693sm7730579plh.44.2023.09.04.08.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 08:30:44 -0700 (PDT)
Message-ID: <3f128253-7524-7bb1-5865-a432f39ba703@gmail.com>
Date: Mon, 4 Sep 2023 23:30:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next 0/2] libbpf: Support symbol versioning for uprobe
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20230904022444.1695820-1-hengqi.chen@gmail.com>
 <03f4fdf3-9ee9-7b33-f196-3d6d5c44effb@oracle.com>
Content-Language: en-US
From: Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <03f4fdf3-9ee9-7b33-f196-3d6d5c44effb@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, Alan:

On 9/4/23 16:38, Alan Maguire wrote:
> On 04/09/2023 03:24, Hengqi Chen wrote:
>> Dynamic symbols in shared library may have the same name, for example:
>>
>>     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>>     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
>>     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
>>     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
>>
>>     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>>       706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
>>       2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
>>       2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5
>>
>> There are two pthread_rwlock_wrlock symbols in .dynsym section of libc.
>> The one with @@ is the default version, the other is hidden.
>> Note that the version info is actually stored in .gnu.version and .gnu.version_d
>> sections of libc and the two symbols are at the same offset.
>>
>> Currently, specify `pthread_rwlock_wrlock`, `pthread_rwlock_wrlock@@GLIBC_2.34`
>> or `pthread_rwlock_wrlock@GLIBC_2.2.5` in bpf_uprobe_opts::func_name won't work.
>> Because there are two `pthread_rwlock_wrlock` in .dynsym sections without the
>> version suffix and both are global bind.
>>
>> This patchset adds symbol versioning ([0]) support for dynsym for uprobe,
>> so that we can handle the above case.
>>
> 
> So it looks like patch 1 handles the above case for an unqualified
> uprobe where the addresses match; is there a reasonable approach to

Yes.

> take for the unqualified version case where the addresses for different
> global symbol versions do not match (such as "use the most recent
> version")? Thanks!
> 

No ideas, need further investigations.
For such cases, I guess users should specify func@LIB_VERSION.

> Alan
> 
>>   [0]: https://refspecs.linuxfoundation.org/LSB_3.0.0/LSB-PDA/LSB-PDA.junk/symversion.html
>>
>> Hengqi Chen (2):
>>   libbpf: Resolve ambiguous matches at the same offset for uprobe
>>   libbpf: Support symbol versioning for uprobe
>>
>>  tools/lib/bpf/elf.c | 103 ++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 94 insertions(+), 9 deletions(-)
>>
>> --
>> 2.39.3
>>

---
Hengqi

