Return-Path: <bpf+bounces-20361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 427D983D1E8
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 02:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740081C212C2
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 01:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F17D64F;
	Fri, 26 Jan 2024 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ahOKIwpR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B59399
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231530; cv=none; b=YKJA0hQ8nvxuieudt4w/klm2jFQbBBC5XsMQSMdV0w539ri+DJOcW+x4krRkiBSJAsnwZq59oUOdt0NY2ETlkRe2tZHoPj5MbNfOi5lfPXHUW7fk6fHi8lTuqgBqpXGu3nsM0SdwdCTheUKPyAEjL3YWgeWV7tOfzjKdqsvnK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231530; c=relaxed/simple;
	bh=0bbnwSQF1hRO24zmVcxZCgmVR6kh+/vVaLKJ/rj/OZA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRtXdluQBSqZc6FIjCl3s8+1VEhHaj2/HsTEq/1u/jfFo5N5rR+X1vrtGZeA9n3BMzhKqkGezVUPZDPx/soznBm7ukkmLDIy1v1FlTzAPbG7t12ajTKc0q8cCC3gibgpSYGhfgNU5me8rjCXEoE/EOko5PHTxjazOqq7/hox5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ahOKIwpR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddc2a78829so1429538b3a.3
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 17:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706231529; x=1706836329; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/LRa5c0xfQcPoEI3iLfcaoTA9F5YlClSHNNttrrjsM=;
        b=ahOKIwpR0bZElf3d2aq3/bdp0ieaFa1tZTVN2teC6LSoI+3IPt1gGm2Zf4gH/EyOeE
         IPqUHlChBvB2Awhwp+Ma0sIrH7RQkGVddCPDfS6PDkHBj/Db0z4sHX2Sm18LjpdJqNmM
         vlprMleqIytXrPTEr8T/mQRyfUERejJhZQoG6J1YtIGqWbzf4AKFR4f5QC5etxd5Qlpg
         ojITsSxVdkr/z+vx8KyeqM8sZ6tbOK9S/H9WiB3GGfejvtFUkm59M95dVzi/p4JrbqGm
         h1TrsKrCVs5I/RITso2+dGtk9qCZCZfN62FtSvZgF45O8PISe4q/Tn1X+nXtxgC7tubK
         S1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706231529; x=1706836329;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/LRa5c0xfQcPoEI3iLfcaoTA9F5YlClSHNNttrrjsM=;
        b=m7gNywMHiwfyZ7jMIXy4+VUgXD2mZFdaxA6gb1U6zyo8Qz++0F8J+J0pgf72No/J1W
         nIPhxJLbRlw9HA8FCiyHoF5scfNYIOn0g815OoRB5cLUwXYfPdeXir4ClYmtkYRfYmMN
         3PPUZOhNLqfY2gbxHAc0KykR62ynHtW7sN+Mm/I7KZ25vR0oQ0zmoduj7KV8f64GIKFn
         lgEpZXbD0mLjzIf87J7VJCgMs+HYOuqsj4lyImeM8wLq8A4HRzmH0yka5PHpF+xsPsor
         aYFAUPx7F6viOyNWWFQtR7Mrd1YqdiW55MXnyLO7DbTYUs821+d7DrW2IEQyrt4gBreC
         3vJw==
X-Gm-Message-State: AOJu0YxbzpFuhoFrhLh+flzPGIlxZzI6sSDP7v0BQRvz3NFqkD5mxf1a
	tdVgHEOJMAq3RT8bcgct121GH7lHsqVJxj/yfh/C+VFbi6+fxoxv
X-Google-Smtp-Source: AGHT+IHzEz+JTEOln91glJ8FbdhNkrzxT+c1Upo2SxzYjgolCXfJTg036g84IbwqMEakq0S+S0g1eA==
X-Received: by 2002:a05:6a20:8e04:b0:19b:435a:a265 with SMTP id y4-20020a056a208e0400b0019b435aa265mr547317pzj.52.1706231528651;
        Thu, 25 Jan 2024 17:12:08 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id pq11-20020a17090b3d8b00b0028e01ddb6c2sm154964pjb.12.2024.01.25.17.12.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 17:12:08 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com> <08ab01da48be$603541a0$209fc4e0$@gmail.com> <829aa552-b04e-4f08-9874-b3f929741852@linux.dev> <095f01da48e8$611687d0$23439770$@gmail.com> <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev> <1fc001da4e6a$2848cad0$78da6070$@gmail.com> <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev>
In-Reply-To: <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev>
Subject: 64-bit immediate instructions clarification
Date: Thu, 25 Jan 2024 17:12:05 -0800
Message-ID: <259a01da4ff4$adfe9c50$09fbd4f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpP87ojFjdXkSD3TMCG8PsKBCFdrw==
Content-Language: en-us

The spec defines:
> As discussed below in `64-bit immediate instructions`_, a 64-bit =
immediate
> instruction uses a 64-bit immediate value that is constructed as =
follows.
> The 64 bits following the basic instruction contain a pseudo =
instruction
> using the same format but with opcode, dst_reg, src_reg, and offset =
all set to zero,
> and imm containing the high 32 bits of the immediate value.
[...]
> imm64 =3D (next_imm << 32) | imm

The 64-bit immediate instructions section then says:
> Instructions with the ``BPF_IMM`` 'mode' modifier use the wide =
instruction
> encoding defined in `Instruction encoding`_, and use the 'src' field =
of the
> basic instruction to hold an opcode subtype.

Some instructions then nicely state how to use the full 64 bit immediate =
value, such as
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst =3D imm64                  =
              integer      integer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst =3D =
map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst =3D =
map_val(map_by_idx(imm)) + next_imm  map index    data pointer

Others don't:
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst =3D map_by_fd(imm)         =
              map fd       map
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst =3D var_addr(imm)          =
              variable id  data pointer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst =3D code_addr(imm)         =
              integer      code pointer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst =3D map_by_idx(imm)        =
              map index    map

How is next_imm used in those four?  Must it be 0?  Or can it be =
anything and it's ignored?
Or is it used for something?

Dave


