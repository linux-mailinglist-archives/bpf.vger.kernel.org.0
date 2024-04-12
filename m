Return-Path: <bpf+bounces-26623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897A88A3281
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3901C24641
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561F31482EA;
	Fri, 12 Apr 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxh73LIZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4C15914E
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935960; cv=none; b=Cf/OP/JIJcrT2tojEyJdtg4VGLFEJW5Pzbu1MEPcgemzoQ5sx33P7MVHDJdnUg3ZX4SjoTnnkkMNQWjVWN7/ak0ShbqL+6Iu9J5+UgO23PziOr2Azy7e17UCKgW2WWYA87gum2yZOPZoYLzn7vnygUMQ7UgA42Y5uy14hXbCJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935960; c=relaxed/simple;
	bh=j93jEF2GlD+i0MVOEMhm2vuLbdm2ki3Q9BlnhRi3w0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rS4NhKeQiKwslO4UzkJzKh+CEKceHIxe1tYUF6Nl8srba9vyMJ+peEZTAvkekbOjix95Ct71WD4JTkWyfGloUtHEoWvhksAiMIZlyXT44hBMe6cA4TniE3m7J/FJBaU5LKnC1RgBZxfCMM1of6Qk1CnT/bJyWR8DHjhyw+saX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gxh73LIZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516c403cc46so2275062e87.3
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712935957; x=1713540757; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j93jEF2GlD+i0MVOEMhm2vuLbdm2ki3Q9BlnhRi3w0M=;
        b=Gxh73LIZJHNjvXmBfoW3KLA6gUYdfRtvXQg0L3JQALspfduNuVxunO4rNfvKeS5Xkj
         VkYfWMNCYVKSms8mfo8VA/xqqj0RKJCRp6xGFfh1Re0L+t67abgsa50SBJ6D6Y1hmTKn
         SKsxCwfMtiB5EcExVsIal5CLpw+MRYm64ICOb051nlZ2cvtLA7gt6o3eITw2ZabtmQjX
         ZEgfEEujH9xp7mhNUx+ExzRVtnxPcCOxvwSOfaXFY4xg7vD4GC2sEepUYspVt4Kwkd7N
         zly3yyxkSw5q6iA565Vr0OxlPIOGH5xvYi+WuTGgoqdR5fgkUvBXKFwpd5SzABffDeIE
         r9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935957; x=1713540757;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j93jEF2GlD+i0MVOEMhm2vuLbdm2ki3Q9BlnhRi3w0M=;
        b=KnQJS634CFVP8b2wRkuBSKj2R1b7cLCR2YA1ctPjqVPcMP8U9drKFzoDGFZ9gO8L5A
         3VAWvRSuoi82NdM1+8dUKOi7EeqmXMLavGvsIljLBfmMSr7uBDnUiXHVFNoN7v/WpIUy
         MjPvld6LPbDGpScCJKcwvQSr+nJ6Tp092YWFK/OAGkqUg+fSNIvjEaS1VmD40SEtzj3U
         2Tc6Hh7O1O0SnBJ1jQKyE2STjOcLFilH/O7RSe0QWO0El9LXlNoJuWH72BI17ayhnQdD
         LEj8OtxgiowNMCp3K5T1O9LpT7gGTKTxBRYgC7XNg0oMh0W2A5ngHyvqVtV9uOYNl+Zs
         r7xw==
X-Forwarded-Encrypted: i=1; AJvYcCVRRgmQlu0nO+0St6YCiME+sRKvu7GIWEJzx+1mMpiRwi4WiF/IP3ra9GgR3WgIpgem1SqCh4a+XpiLUzYKkncnC2kv
X-Gm-Message-State: AOJu0YzDjH+L2G3GgUcyYG+neIsyW2HJIjbDhUanUiyX8l65eoG8hhCG
	vZBsiUq2kfcCrK0uGTYE3Dq1tPmhPmVmdl9yz+Nk6UHHP4/njMQIBm8DafTT
X-Google-Smtp-Source: AGHT+IG9X81+2V1l9uJ0YkHXho2ZjhN+n6k0mODMMJVvMX7U3BdQrAlZ02ARaPKxj+2CXncZtMtkbg==
X-Received: by 2002:ac2:41d3:0:b0:516:d3de:88e with SMTP id d19-20020ac241d3000000b00516d3de088emr2068258lfi.49.1712935957268;
        Fri, 12 Apr 2024 08:32:37 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id go36-20020a1709070da400b00a51fea47897sm1930091ejc.214.2024.04.12.08.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:32:36 -0700 (PDT)
Message-ID: <8d12fcfe44693bf69382951c8b090b06df8fe912.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/11] bpf: initialize/free array of
 btf_field(s).
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
Date: Fri, 12 Apr 2024 18:32:35 +0300
In-Reply-To: <f1957694-13c3-4b4f-96f1-451b8acedc4b@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
	 <20240410004150.2917641-6-thinker.li@gmail.com>
	 <57d016ec8ccb9cbc454f318d74b6d657de59ffcd.camel@gmail.com>
	 <f1957694-13c3-4b4f-96f1-451b8acedc4b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 20:56 -0700, Kui-Feng Lee wrote:
[...]

> So, I decided not to support rbtree nodes and list nodes.
>=20
> However, there are a discussion about looking into fields of struct
> types in an outer struct type. So, we will have another patchset to
> implement it. Once we have it, we can support the case of gFoo and
> all_nodes described earlier.

All this makes sense, but in such a case would it make sense to adjust
btf_find_datasec_var() to avoid adding BPF_RB_NODE and BPF_LIST_NODE
variables with nelem > 1? (Like it does for BPF_TIMER etc).

