Return-Path: <bpf+bounces-30868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352598D4033
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4147284DA2
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 21:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEAD1C6884;
	Wed, 29 May 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1ePmp3S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6FE542
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017627; cv=none; b=S/Bm0EpPVEBT/T+l8pvvhhW/1grnzRXiYGl+xrFq88cBSa1SzdH8p1HpQcM/OjacLRn1PF7LBqR/p1QN7uVHtXu4Q12dcWg19MPXwRlxyjExyzH/eKKn3xrCbsKsD0bS4lb5wjXjnQ8Hx97aID54UG+p9cswr2uj4PnU7ixLU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017627; c=relaxed/simple;
	bh=vE1Jpf5w5OjmkjkreQuvBOR1eFb5RC+aLiAxUbYTAh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrfwLC86SA8BGQ9zIOm8M5OvdVzehgHTckJ419SPx1kpARHzrfcpOTx+sGbZO8jvdV9ifrqMHtrNx5Uw2+WNtLxTYkaL0YVvIe4XiOY++0T2A/MvYYayhRFUdEVrbYFdatHG0TPxF3qArBpRzMto0DfdEh0BTv50776ejoAn2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1ePmp3S; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-357ec504fcdso155167f8f.3
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717017624; x=1717622424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE1Jpf5w5OjmkjkreQuvBOR1eFb5RC+aLiAxUbYTAh4=;
        b=e1ePmp3SGJY/1Y3AmhfXx3swHo6rixv5SVeFEDBr+VEwdnllBvinXhfy9zdMD8/mLe
         zbCUPXTGSCpaSzp+JjM6r59srCwMd+orxUhVK8u45onY7xcINtaQNdu1TZV8lDjYRj30
         fnYwagMg1GvbOdxVuIwGujJ+vhnHmNFwPG8edIuB5GhaxFNa2lJiFdW8em3JB1skqmx3
         bn7S99YRaynN0BcYoI6F6K+j2prnzVELYqvMq8uVzhVWogigC0s/Aso3zsnWQVZF9gqV
         5n3ft4O91urC8QWO2m6M4eTyciELNcFUo6kbpT9EOFgBQZIWNY+XN2YV62JXMs+sfuC8
         P5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717017624; x=1717622424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE1Jpf5w5OjmkjkreQuvBOR1eFb5RC+aLiAxUbYTAh4=;
        b=MfgGvMaT8KhHX6oTlueRX0iMxgBr4jIANmfyipELvB49iTzMe+FWF1q2ExRtyZpftk
         Lg0mmgYVYh4i8sSJN47u31y4Vvi/XBVcEuCilE4hRMDbxuR7rPPfjV9Wli9BH95YpWtm
         6W9ivh/vWPEeanfxxij/Tx+u0kyK1dLfhe3MoFCCcvu2hMDesTa20WdqB95gamD4+yHr
         1toPoMg4K6OrgPEAV1sHOpeUatLKqX/RyHkqJ8XTwSnRktvpNaOQAyRYsFXcvlWydpEJ
         8jjWsHTyuWVrbc4VAsKrNF05EDNzFfit1D6KeULzZBkWa9i8ty1eOCJygziOsLb4Ed8z
         Csfw==
X-Forwarded-Encrypted: i=1; AJvYcCWQKU8wcAaJAg+9eF7KXsqmm+XXJEk0XoMUOTjBgEOvSOBUHKFBhQj+9ATXuBi6bmu+gY+bgF/HCKuYBBl705u5LRWO
X-Gm-Message-State: AOJu0Yzs6x78XCm6MwcytYNF/wMmM8SBAPhvbpDdG2ak/W7veq9eOcJ+
	qfQHSggaR16hjTl3koJZ02Gl+Xn0N1EB1aBAMAgggA+WeokcWTl5gwnlsjTn2IF320RX5gVoL/o
	HXlTcRTrQcReahJuDTyYKbA2pR0xJweCl
X-Google-Smtp-Source: AGHT+IGinpt7rbnjrZ9ivPuK2wPEbm8ov6rxc1MTDt2dpxkhFJ9iOU91DMDEqw/wc3BQRByuXzJssVx9hIt7wxnt0Yk=
X-Received: by 2002:a05:6000:18e:b0:354:fc03:b44 with SMTP id
 ffacd0b85a97d-35dc008704emr225337f8f.4.1717017624171; Wed, 29 May 2024
 14:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axP3gGsdQC+CYXjBCxk++9U5upfmBAK2g9=ZNnD7N8tY3A@mail.gmail.com>
In-Reply-To: <CAMB2axP3gGsdQC+CYXjBCxk++9U5upfmBAK2g9=ZNnD7N8tY3A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 May 2024 14:20:13 -0700
Message-ID: <CAADnVQK1tA3cjSwH4GK81R9rkVG=y_aq2a4gUw2mkUn0G8OT8Q@mail.gmail.com>
Subject: Re: Potential deadlock in bpf_lpm_trie
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, pgovind2@uci.edu, 
	"hsinweih@uci.edu" <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 8:53=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Hello,
>
> We are developing a tool to perform static analysis on the bpf
> subsystem to detect locking violations. Our tool reported the
> spin_lock_irqsave() in trie_delete_elem() and trie_update_elem() that
> could be called from an NMI. If a bpf program holding the lock is
> interrupted by the same program in NMI, a deadlock can happen. The
> report was generated for kernel version 6.6-rc4, however, we believe
> this should still exist in the latest kernel.

Fix it similar to
https://lore.kernel.org/all/20230911132815.717240-1-toke@redhat.com/
?

