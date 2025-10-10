Return-Path: <bpf+bounces-70742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85547BCD7F8
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23CD18891F3
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E902F2617;
	Fri, 10 Oct 2025 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0pDKvYp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C37146A66
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106154; cv=none; b=Y65fOdwOuRQzD7XFSeFMWBbmo4DR8JrKf8abSoWmMeWWT7PFGcnl3wiEMWCv+odb968iboJwK3o7XVzHrFBMvH7L8pp50snfhGPu1fpVCLRLlWwLjZivcT16k7VTZybnZK3SFyhoWPMjSvuSvfhIdb04wfyC7CiAhlw0A2GblVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106154; c=relaxed/simple;
	bh=7dndPtRevbITE9ffdTBKfJlBf/TdoDeFhl4O+Fj03Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiY4zVTnD43Vh9LnOY62jL3/SlqC1uxICX4lv7OG2INd+so4l6MV7EnTGOp8etjkoy4MK/8hZnpou4E7I5jQQV4f1O9oQcM0lrz+fkq1oe1k2ucZJVPO9ag+V2M0Hf7C/+Fi5UEjTD2MQ6Gv9gRYtlw7ZuQYWA/F8FfTGUJgEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0pDKvYp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b631b435d59so1375799a12.0
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760106152; x=1760710952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CuwuYd6rsM2ZdZipwD4GPWKHOfizRXrtv5NCir+9FI=;
        b=i0pDKvYprOqKTUOvlTb0+Kwemaf4fSwtBs0seoQFE0Utg5Sr+RMW8UILA/0c3A98ji
         9RNY51cIh+lXObvmkLfZC+62DbEOQudHH3I3jzbC8KlAK3cRYauXcUQJwUz/UY+HLSGG
         cfjAWYUZ/ptTnnqO1stxYZq/fQzxSncXvVJkPS+WgeWpkeTFif7vkbrzjBYNnps3/x/Y
         zahLYrbRNKe4zU6dUP9d1IfRGImscJ6QkWvi6zdUjKBZp2ftW3uZjkyjSObad42b8syh
         JF8Av+bJcGJqs8/9LZQbbGeAgI6kdKS2WKtk3WY62/MqRJ1Tow3yv/MLHFGmD5SAEYeC
         BI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760106152; x=1760710952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CuwuYd6rsM2ZdZipwD4GPWKHOfizRXrtv5NCir+9FI=;
        b=lmnzW4mTkjgp0x1LdIeeo+mpwEqTQVB9XeboEZ1lEi2yzo+Nc0Q568sF4hfbou1KNj
         DvOg6CyoAm5c1N16U3A1waUaj0vph4eULcoWNeFXP5crX4qxyQA8VEGR7uWikH8dKXq/
         yboKcwg+mTQNm9HcrqqABvXxBD4X7Ha9q49GRJ1/AgJB1QISSLQ2yhibV8uEcnybrX6C
         xTBPLp5Vd9wwXF1iwxl7W5oxb5jvzZUDP52wodkQ5maPjWkdPp1FuIWD1fAh42tyU9AE
         u6SAUV3ZJj+Z1JoURJTbaBya9o7iY7CdVk2jKn+GVAzCLdu3lrKNGY7DYYJ4uAzZJ71B
         I4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCU9/KqqmIwTblAhabLqW6Sl7nuvcP4PMruDfAvEojG5yAveE22uFzcATTb4B49sBysojYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOLIinptEdbAq6hElMXfmO17zvJKCNt2RGtqyI2rgEPduURw8
	wrC0NWFchlGd2g6OT6uwh6oWc8XCcMdCg1lLacRK8bsdE7uaqJzUVfa+
X-Gm-Gg: ASbGncv6JM75bc35IhR1WFhp6HYARuvWl/dEsCpuMUjXX1hw2v/308Zbq3cNWq0b+zI
	fdm2WBapOH5YehrJwl0yLbPGqhekkVHVzA56eOmmv7h//TizOZQDWXtblEiRqvSgB+R/zz6dNWq
	ST2NUqrw0iCrVzVsNHOkmWrdu9wHz9E2P1AI++VeIM1biScMwrQsdpBlGfT7WOG9tJCwcs+aPk8
	1pR+d+J/xLC5EP0AEEcYLS++rSL4QM/0l9HJuKCnM9o82qtgXIIEG1ughjXq3D1PLWrqtjEU74D
	ueNo2JTh037iE3kurQB58jVA1FWOvZ2XqZzC9lmGOosG/QU2zFEkonAfNZhrYYXZTpKcRsUQEu/
	cMzEglBYA8fKjDxYcUsT1oElfwQFXrNoMJ35o3twtz4NFGr9PGnCp6/99XdpQ063exQjiB1Z0wl
	M=
X-Google-Smtp-Source: AGHT+IH1+iBy8nFHwk58M7adbDk6CNfAFBIzVimB+kebnYyWU9N7MoWT9usmV/V05WE/d2nIHvMYkQ==
X-Received: by 2002:a17:903:4b50:b0:246:a543:199 with SMTP id d9443c01a7336-2902741e471mr151973715ad.54.1760106152226;
        Fri, 10 Oct 2025 07:22:32 -0700 (PDT)
Received: from [172.20.10.4] ([117.20.154.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9bbsm58596885ad.121.2025.10.10.07.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:22:31 -0700 (PDT)
Message-ID: <5c68715e-d851-44cc-ba14-0886e515ef45@gmail.com>
Date: Fri, 10 Oct 2025 22:22:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Menglong Dong <menglong.dong@linux.dev>,
 Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev>
 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
 <405caf71-315d-46a4-af35-c1fd53470b91@gmail.com>
 <CAADnVQK8Rw19Z6ib0CfK0cMHUsYBuhEv8_464knZ4qFZ6Gfv2g@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQK8Rw19Z6ib0CfK0cMHUsYBuhEv8_464knZ4qFZ6Gfv2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/10/9 22:45, Alexei Starovoitov wrote:
> On Thu, Oct 9, 2025 at 7:15 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>> The verifier can rewrite 'bpf_reg_aux()' into the following instructions:
>>
>> dst_reg = BPF_REG_AUX;
>> BPF_REG_AUX = 0; /* clear BPF_REG_AUX */
>>
>> As for the architecture-specific implementation, BPF_REG_AUX can be
>> mapped to an appropriate register per arch — for example, r11 on x86_64.
> 
> it's taken. There are no free registers.

Understood.

It would certainly be beneficial if there were available registers on
x86_64, as that would enable certain optimizations and improvements.

In a similar direction, I have been exploring the idea of introducing a
dedicated BPF_REG_TAIL_CALL register to unify the handling of
tail_call_cnt in the verifier. This could help standardize the logic
across architectures, particularly for those that already employ a
dedicated register for tail calls, and allow JIT backends to simplify
their tail call implementations accordingly.

Thanks,
Leon


