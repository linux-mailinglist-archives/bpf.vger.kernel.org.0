Return-Path: <bpf+bounces-49637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0EAA1AE7C
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1140516158E
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 02:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C6F1D47D9;
	Fri, 24 Jan 2025 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivgrgRav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269851E495
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737685021; cv=none; b=HLfzSjfPtR8zfqb1i6RhgrRzRAn6vpXAA9wDWL9JuImvpy0xvnKy3lIBZIVeWekAQvjoaBggcJbiU1Y+J0xvqRfBucGcenqwyLhYwByK6gGBq898HbEMBq/1Oj4oA913olEnOUcMWkVXd6/Wq9Ts3OVUAn+41+fQ2BEeGkMVeTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737685021; c=relaxed/simple;
	bh=xUvp4ox3VrZqUBB4sXk1V2VAd12YHYjefH3PWWeE/sc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cqJJTZNhJWaipgp0yAkIq2YmVlDU7dyRR/psYslAMX/lIVZxo1hxKm77wmTXO9p3ztAb6EIlzQ5atbh0CdteZFEb9SuAkjcs06UKB7Ck63gXQkl+GENHuf+POYfVjVA8veuMKezx5COY0g19Usc9zE4ilBoZ3RyOEXy6uw1KdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivgrgRav; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f8263ae0so30159945ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 18:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737685019; x=1738289819; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm2NSqfTRw1v7MWwQNOxN4mGcrUaa+85eRB5h/26vxo=;
        b=ivgrgRavKU/gUPDVMIavPCcu+BDUp1LMSt5qpejjO8kp2C4dvUYwgddRj77GAjHfTV
         OVzB3c43DSCuDVLj8ZLKHr+vVjabFLgLfhPIK4MiOzdBAKjkgkprn7Jpv1msm8BFhY6g
         C2BFMEb22/Yr3xqmu/aH2WIlrjftpUS5nZU8WeCKnTi5wdFoXcKfWOXsY3F33EzvsIeM
         s6VYf5To5ChJ7LDMUjw2bER73lNl20bvAjeKQu45qYhy318CH8LcvJmKoL4l7bRY1IkQ
         Z9JqxhKEfHvjy2PSHpAonWVh+Ae2mhSNwmJ548/Bbl0wySF0E0uqtB6/8SEfhVC1KTwK
         AYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737685019; x=1738289819;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lm2NSqfTRw1v7MWwQNOxN4mGcrUaa+85eRB5h/26vxo=;
        b=lloK5K6d2n2nv5gsEZYzNs/7gM84A9m2a9QE7NObga/Uck2pgqWc7ORxh7bSejrRC4
         pC7DpKlrqxFf9jyGlvEfL4mWwpyBFhCE1g/xwhJY6lxDMBJ6TsbZcsh9UzVsAYJ6XUBe
         hGZftG0Oa8cBoqb3Ye1KSNL3txnztW95Gm0uBb0R6TsihkQAEMNcPoelS+qG5acYrb2P
         rgGi8Wp+N9kbmJX7b7LWMMhqyOKlgvtJ02tojN/vOSeoLGNBQ3PHwFszfDlqBTmbPyvS
         eBG8aCgUrRBxb1EZfKbHYcaJhv1cHxL3lhu+QZUu63Q7COsx4Vz7PlCasHo69TuaVBY4
         gRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZg61W27EJrG7VAzpC8Shm8kaqfkUzx4oxPt+omwEiMPzM2cfjZo9t3nqE1x79wvbv6Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIojLWUZ0p3xpAUzZG92GAsEmS9hqYaNdZmHM2aulzTl03abl
	tn/dMA2GSN+T2kFW7hX8hCmuw2WYpkCeg0TJ701MT0p6/zT2+4Yc
X-Gm-Gg: ASbGncssjxuL4EMxgR1UxTeR2bTAkb/vO+CJBQyBXJ4Vm7g6p+CVy7kLXy4PSKKwB27
	gkcLacgzW/k2ibjq9DZwMwKUwYvzrJpeloVuSp1S9rU5fp93i9EkZbPXQ/3BeDlM370IK207KkM
	IlmYzYJ1aVCUfppQFixe6yDNCo1FaGQiAS11WFAaquFvXhZK0plyqD6Ix44BAz1YkEfBX5UkRR8
	00fw8UPlkL9VDyExr2K/82DaaCE8bTbhy6qYjcpAFaNRUrdkJwVzAP1BDYPxc2Ofvd+xfDcjlni
	ow==
X-Google-Smtp-Source: AGHT+IF6VI9tibYTsPo6rAH0el+Zjc3Q6nq6FkDd1sjPVsCaODRfsVAlyD7VvrcfSqHOLB6ccdxRog==
X-Received: by 2002:a05:6a20:12c8:b0:1e1:e2d9:307 with SMTP id adf61e73a8af0-1eb215ad783mr41475326637.33.1737685019282;
        Thu, 23 Jan 2025 18:16:59 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b323esm701245b3a.60.2025.01.23.18.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 18:16:58 -0800 (PST)
Message-ID: <a36556ee79898a0ccfaec42e1c70ba5593b1887f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/1]
From: Eduard Zingerman <eddyz87@gmail.com>
To: David CARLIER <devnexen@gmail.com>, bpf@vger.kernel.org
Date: Thu, 23 Jan 2025 18:16:54 -0800
In-Reply-To: <CA+XhMqyt7LGkitBrNE1goRMQdsP23=BwLsCor0pY+mM6zO2+zg@mail.gmail.com>
References: 
	<CA+XhMqyt7LGkitBrNE1goRMQdsP23=BwLsCor0pY+mM6zO2+zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-21 at 16:50 +0000, David CARLIER wrote:
> libbpf.c memory leaks fixes proposal.

Hi David,

please take a look at the documentation regarding sending kernel patches:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
In particular:
- the email should be in plain text
- subject should be present
- the patch itself is a part of the email, not an attachment.

About the change itself, why do you think there is a resource leak?
Here is a fragment of bpf_program__attach_kprobe_opts:

	link =3D bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
	err =3D libbpf_get_error(link);
	if (err) {
-		close(pfd);
+		bpf_link__destroy(link);
		pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
			prog->name, retprobe ? "kretprobe" : "kprobe",
			func_name, offset,
			errstr(err));
		goto err_clean_legacy;
	}

When libbpf_get_error returns a non-zero value the `link`
is either an error value or null, so bpf_link__destroy
has nothing to work with.

