Return-Path: <bpf+bounces-34418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9C92D820
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0C32811F6
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AAC195FE0;
	Wed, 10 Jul 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8zVYiWI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEA1B809;
	Wed, 10 Jul 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635265; cv=none; b=tkCWDtZWtwiB/QBCGhrjnoAIp8vu6hbDHbm5Woy7KsfgHB+y/nsAWhML4SOZ02O9Ae3yqYfRFNpUOPSEvlARE7icWtP7uNgABBVJXXKqvLjuOQwPREU7gqz0gIgo1yMOwLOseh+TjwXYyWJz65TB3NMf5eOk+0+Z7AiGQL+O7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635265; c=relaxed/simple;
	bh=f8ykv9uJVkjGiFVm2W20/V26D7sBzuKYq9icfj2JEuc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=K/0uQsdEqsoGtg2qIqS2P2lhNe057PeUX54J+Y6OJHZ5Ms7WPI+PUU5ddMX8NmgsgypU41TWmw9mA4eG0/zSeA8scixf1CWv3EwKm1tfYphWjEMc3g1d41SWzCuBm2DgW15vgu1uVQckZGWpT2RYCTSUz52kbiPKZKmV//gRcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8zVYiWI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e9a920e73so72923e87.2;
        Wed, 10 Jul 2024 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720635261; x=1721240061; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+sF/bjhxyvhZbt0rQa40ozfkYj8d6417QqMvSP+eRo=;
        b=O8zVYiWI5XsVwkg8cmWLU4agCl5wpg/KpQdOb0DTes9ds61pgke0+f/1ldVyGfAh3U
         jRpUDwZa+1kXqYhJutxXgGOF/R2S/5E+uNOBfPBTemn79YOMwlq2gOwvxEJ+QFyFLHMj
         +8Yh3Fqa5Y2a0fcH8y6uO3+WPQqIWRzkjnf2EvxYovGHwTHhGG8ESVmRIvL4HmkZoHX8
         ZGiHD44hr0RV2gYtb+ndzv7jueqiCaPFAmoQKIUupylw0n8bzwpiYIDEed5ZP7012n4J
         Tyf5Sl9N2Gnlgw+F306SQDIq0UW3KKArfabwajk7at68oJ911PmW3y8Dy9S8+3nK9z/a
         A2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635261; x=1721240061;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2+sF/bjhxyvhZbt0rQa40ozfkYj8d6417QqMvSP+eRo=;
        b=I50Iuu+69Kxplz7rZSWdriUKg8/fniNpiis5I4UDKCX+MHp2+AfkGccFJaTdRs3xSr
         XOuSbAcmxSP6gbcr7DM9xOjogpIIUfRj/wLritRtYGyj9HIeKSsJABNDuZqJqM9KRHrk
         ziIrj/RVLMCvrsbjCdrgQWPWjeON+Bd9oalGYrWQ5b+LM/AOZHRBsD6O8owIPGfRlgKd
         G/mQr03kb4UqLIsuOY6hrd2ajwvgNH4Puxv4lOm1OCERNe6Nf1juY5WtGg4KWCX1fKXV
         VdaXMQXL7K739A0zJnBWzm5NaNh00io6RlxFll8H7nqa1CjbAuLov+/ugGCab9ugwe5P
         azFg==
X-Forwarded-Encrypted: i=1; AJvYcCWn3Dy4uJnCuU1HvOdi9RtHz1aMb1qPtDmbh3yYl4y2TNUnVZ5LKuMUbq7gqQ/jxHK/jNWWkbYKnQjN6Hn8gDEsYFSR
X-Gm-Message-State: AOJu0Ywj0ZxsuqjhobW6Qze+nEEodc2EXlGPAZroAvbYcKll+ASnAMfN
	PBLDyCBz99VlnTatujpX6FSYVtyKZqgdeL5Vi7ewm6y0yuuThjmYzvW30g==
X-Google-Smtp-Source: AGHT+IHZXdNH9l2sQOHJbWoz+cYb/7YmC9FdbdTnmBbBTYD2iTGbYjZOKdXbFdHy8bq5lP7DBdA3tg==
X-Received: by 2002:a19:8c4d:0:b0:52c:e10b:cb36 with SMTP id 2adb3069b0e04-52eb99a0702mr2615204e87.33.1720635260981;
        Wed, 10 Jul 2024 11:14:20 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-148.xnet.hr. [88.207.43.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279781dc79sm12765655e9.23.2024.07.10.11.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:14:20 -0700 (PDT)
Message-ID: <a8b20c72-6631-4404-9e1f-0410642d7d20@gmail.com>
Date: Wed, 10 Jul 2024 20:14:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: =?UTF-8?Q?=5BPROBLEM_linux-next=5D_/kernel/bpf/btf=2Ec=3A7581=3A9?=
 =?UTF-8?B?OiBlcnJvcjogZnVuY3Rpb24g4oCYYnRmX3NucHJpbnRmX3Nob3figJkgbWlnaHQg?=
 =?UTF-8?Q?be_a_candidate_for_=E2=80=98gnu=5Fprintf=E2=80=99_format_attribut?=
 =?UTF-8?Q?e_=5B-Werror=3Dsuggest-attribute=3Dformat=5D?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear all,

On the linux-next vanilla next-20240709 tree, I have attempted the seed KCONFIG_SEED=0xEE7AB52F
which was known from before to trigger various errors in compile and build process.

Though this might seem as contributing to channel noise, Linux refuses to build this config,
treating warnings as errors, using this build line:

$ time nice make W=1 -k -j 36 |& tee ../err-next-20230709-01a.log; date

As I know that the Chief Penguin doesn't like warnings, but I am also aware that there are plenty
left, there seems to be more tedious work ahead to make the compilers happy.

The compiler output is:

./kernel/bpf/btf.c: In function ‘btf_seq_show’:
./kernel/bpf/btf.c:7544:29: error: function ‘btf_seq_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
 7544 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
      |                             ^~~~~~~~
./kernel/bpf/btf.c: In function ‘btf_snprintf_show’:
./kernel/bpf/btf.c:7581:9: error: function ‘btf_snprintf_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
 7581 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
      |         ^~~

This doesn't seem alarming, but it prevents build with this config.

7541 static void btf_seq_show(struct btf_show *show, const char *fmt,
7542                          va_list args)
7543 {
7544      → seq_vprintf((struct seq_file *)show->target, fmt, args);
7545 }
7546 

7575 static void btf_snprintf_show(struct btf_show *show, const char *fmt,
7576                               va_list args)
7577 {
7578         struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;
7579         int len;
7580 
7581       → len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
7582 
7583         if (len < 0) {
7584                 ssnprintf->len_left = 0;
7585                 ssnprintf->len = len;
7586         } else if (len >= ssnprintf->len_left) {
7587                 /* no space, drive on to get length we would have written */
7588                 ssnprintf->len_left = 0;
7589                 ssnprintf->len += len;
7590         } else {
7591                 ssnprintf->len_left -= len;
7592                 ssnprintf->len += len;
7593                 show->target += len;
7594         }
7595 }

Hope this helps.

Best regards,
Mirsad Todorovac

