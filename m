Return-Path: <bpf+bounces-76831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03375CC650B
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 07:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E035030A2DBD
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8633509A;
	Wed, 17 Dec 2025 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVAZ19kF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB62DBF76
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765954535; cv=none; b=fNwT7lJQpsP+VLr+ZH392ftNhcKfRdtI0hKusLpZmZ9wO7brTLiDoSaubE+/c0pKxIl+mMhwWGabakBdeFENTkf8xFENd764gEphQ9N8VyPQPkGxZjnAKsG0l/uZ+imUlQbYXzkm7L8DoiFOvCpRg/q0vat++o299vTa/2VXXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765954535; c=relaxed/simple;
	bh=WyvyudohbmTmLOLE/N0RAc3uKv396NjhsncEDshJMJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfN1woi/wdcZsod7zuWtl/Ckq5K6hevSCOpoamCj7XsemDM+TLZzwpuFHl4q3SU8TMa4GRyN/UZRVIhR1SPvsPtW3qE8ZXgEDQiPX/D+VPnOAj4IwlspCyUZ/cSbVPguj7DNNvSLY4FIVzmbN91DSuIOv7tFy/69OOBXbfg+j9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVAZ19kF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7ba55660769so4353785b3a.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765954533; x=1766559333; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bBMPtE0IaVeP7pkDtwD4FM1A0HiPwnneHf5c0h3YUqw=;
        b=YVAZ19kFzI79tNQ0I8DTS1hkhSh4SLD1q29Alm1uo71x9vXZvYDXKdLvfiz1CXduwu
         PW6xI3fJxLUC9OZgzipwaVgzFDmPcUylRq3a0BB4RpNnekb0o5MCrdc9g/Me/kkcFaVh
         BOSRjuLmzruhWtmleCki4AwAcd6rSOga9ftHYPK/VSGSfaGeYBm2Qvw6qHuWrt5mXf2i
         NOqwVkfvr51gvd3ILctCNjNE1/1AScWmOa+AJrSVo1Zxv+3WgPFDb5fB7Pi2qP2LjEOB
         4kNNUX9eedxn1u7dR6ZNWMi/joBaF0aBIxeQdUxQa6eQbaCRPDClFZ9euiTVtrqlP3pu
         MUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765954533; x=1766559333;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBMPtE0IaVeP7pkDtwD4FM1A0HiPwnneHf5c0h3YUqw=;
        b=S5oFCDVFyrlXM6YsI+vtZzxNrb1v605pOTBoFRYHBbgREIAbCHYzdS8WX2UPro3/TG
         6XToK8nhi2ocxPXd/dHrZx19W1nqDjoBaRaCtm95o/+IQn0LnUcxUt6Xh6dp0TUDQNWe
         MKzLjBZ3AMI9v5ApCGZ0Tst7K63xDlDHsxMHLHE87ATAqr14rJ7JOGfvtImKgWGo5KYK
         59BsLXFz2aRWea3/QkckYMyPEaiRi7zrBYZhRkPHf11aVREb294OctPOfWXU841IdDeD
         i4wN6hyLEv4Men8ijzm6f2KqI420O72SpRWX+UoQzg4s7tDKmabNnpv6D/fwpbW4v7uI
         psVw==
X-Forwarded-Encrypted: i=1; AJvYcCUP6lFPyzhql/R3wXaIBIJg0AJzPYlYIHg6Y9z8p5IMtM7L+0mGjBXGYg0MNOI9oFH9LRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxQ0oHbMq7JQZ5wrpV5TTvjqZZnHqavt729kJlpvcx1VloBNJ
	g+0C+c0oiSeFKWM0g8m0XZxAtCffxaPquQTwdXhbj72Z1IJCi0bN5Q1t
X-Gm-Gg: AY/fxX5S0iUyoBVKFaovWqUax8IV9U/O5EpoIST98BlybdOPy2RR5VBuInSMksI+Try
	A9GwfJscL4wsIOaX//RBBeZqlIAb6C3uLu2A2xtQIDm570z3OvFvZ/iQzzPEkTuFPUqKUPrFICJ
	1dOd1ZWw6mTupgsgnKIelrNSSQqUgztcE522Ln61PtZz5j80+S1RN0ryOsWlIZwVmzkOTnrqMA9
	rbo8WQoPCvsn23mwv3cn9uO2p1VGAMpAHMpcHAGN44OGru4FP8eg+W71MMCfOn21VRv0rw79qdA
	3VvATgaYVeu7njJIsHwcuZ9gFeynk1q1sgpkTWUzo3qXJJvm8Yh3jcuHGNz/4cSVZGdzorBgf6/
	4vnh4ZRUfrdLRUdDLI2P4vWmgKFWpd38Ca9LK05Ugb03jKwcBRKVuSCZQD5VkL3aRNjHfXqj0UK
	Wb5YoQGOcv
X-Google-Smtp-Source: AGHT+IGaxEl7RuT2Qx5On9VIBO5D2R+xjY6sW2owgECMBk+3kPe45RdGfcEn7baUpqk4AUClN0xQPw==
X-Received: by 2002:a05:6a20:e210:b0:35f:10a7:df67 with SMTP id adf61e73a8af0-369ad9d21c0mr17015586637.17.1765954533298;
        Tue, 16 Dec 2025 22:55:33 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c264211cbsm17091750a12.11.2025.12.16.22.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 22:55:32 -0800 (PST)
Message-ID: <695de859b8af88ddcf53bca22a3ae57d7026b3af.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 08/10] bpf: Skip anonymous types in type
 lookup for performance
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 22:55:30 -0800
In-Reply-To: <20251208062353.1702672-9-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-9-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:

[...]

> @@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
> =20
> +u32 btf_sorted_start_id(const struct btf *btf)
> +{
> +	return btf->sorted_start_id ?: (btf->start_id ?: 1);
> +}
> +

I think that changes in this patch are correct.  However, it seems
error prone to remember that sorted_start_id is always set for
vmlinux/module BTF and might not be set for program BTF.
Wdyt about using the above function everywhere instead of directly
reading the field?

>  /*
>   * Assuming that types are sorted by name in ascending order.
>   */

[...]

