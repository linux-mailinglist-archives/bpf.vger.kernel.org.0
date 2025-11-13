Return-Path: <bpf+bounces-74366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5DC57103
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DCCF356588
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00F3346A1;
	Thu, 13 Nov 2025 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIRp1jLY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C8C2D0C9D
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031394; cv=none; b=p2julbxp1GfPQ128j89u8/NPqzNu8P1cXZCZ89nKaVmvXg+AErmzdetiu4Yr/NgP0k9n+pa0B4lDF0qqREVCMHbr+KG5/1LX3BJGDvQcEWbju7+pua7pqKLHuJzejbbO1JM+DdrykVZo36DD53XAibP3ipWY9cpRdwA8WuDo+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031394; c=relaxed/simple;
	bh=rseXxlu7uEyyNMzYO8cBR2VPyb1joXBKfGdoItwDyD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fb7swC2SADFPtsTacYWdBRDho+e2KoFoVcaLQcys/ghK16jWscXG9NgAub2mSK/e3U46xRRGSlZpKJH+2hDbTFf5Eg84bMTH6rpSY8Jk5LU9nH9tD+VO0ba1wZARZa9zpw2jR50z6ONJ2yBrPspmRndIBrepQfTz9y+a8awyJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIRp1jLY; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso563849f8f.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 02:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031391; x=1763636191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rseXxlu7uEyyNMzYO8cBR2VPyb1joXBKfGdoItwDyD4=;
        b=bIRp1jLY9Eq1F7jz863+H9JZvECEvpjL8otUGf8H7wjP/KoSZiSNJ1rCI65fHCV6V8
         GwyNOcBDVoSzYLjaIEv6zRAhHnr60JUyF5ceErDbCJlgdToFSr924M0/J/XosuA39pX8
         NXrBYEyGV1lOE4kUrcX33vieonsBCug09BNA2pApmkKJUXqH+2+5Ocv2jlso2YGNTDbF
         54Y1miT50e9Vof+Qk0vK7NCuZiRYZffSLa9t+LB8jXonYJIKRCxQKJ/xXohWoepjo1s9
         DiJozNWi0SbWD/vKu5L91q2W6J/yprFumNbJtjQBEr3qrHNHfUTyqnv1YdPdjm1IFHk/
         stwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031391; x=1763636191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rseXxlu7uEyyNMzYO8cBR2VPyb1joXBKfGdoItwDyD4=;
        b=hPzNG7UCNYXre0f95yJRXB1DT5AhG64lSK4+0OmiuP9xsal1RaBTKde5SbEe1fMcm4
         83iJym9roOi9nZ++FK57mxhlJZuk9PwOIa0rWkAJrMi+CIMvp5Ln7PUVRTSoWajpUmlE
         cnR1FhskQsdUDYiOnDZNJadeseRyjFSOXARtT6ayXGIqtJ3UhjvSW4DGyhyu0Vl4g9zV
         RyMPUixwiKttCqsylCSm6J9y8XBqWczTHvUO3uCHCFdagTyIW6TpYCFD35cI/SPJDYYx
         KNGSJyaFz+Jsg9Kz+a+DSC+F+OZQRHAAx5kOF7omryeQvnPuazpwpWdTCMRvviMuz4+0
         ju8g==
X-Gm-Message-State: AOJu0YzFW6bA7ATpuuNc+qyjJmRxCA0wJgTN2W+4/cfsFUTZdrh3OMK5
	vStXHTudUTVWfQhDM4E7CYDC+Xcimrd9xiENqOEHhkXPJal2rVpv1Lh0uhhLkhdI2cRqZ7UdCNK
	+K5ACLEKDzNahG1RtZECCZXVA4nQQ/Zk=
X-Gm-Gg: ASbGncskjdcwdT9fAaivOyfWGStvmTLQq+gWTC6d651sPvJfnsG95kKKI3xCS8q1a28
	BOKVdHM3EhbPoov19YFA1dJtbyqDdUiw7N1E/kvxftu89M89SCQ2ZPERYeU6WTts2pQhnC1wiRd
	Cecc6jNQowyhBYHIbf/eS0R4uBoBATvDYFxwP2EeRJGsYT+QG/+fVUfddaNsDHs0RZnpnjRlOfn
	saJcCmShwBWsNMHpKv0NXEhGJyc/MQymIi8DfSWqLwgTCTL4B0XuEp848NLBSDf1VaaB84AWL+t
	Cb75EUuoiwy5+yKAky0=
X-Google-Smtp-Source: AGHT+IE2myf/PerVI9T4OIFuvtQywaE/Q0ZzpeEhaDmYWvE3doDAQIztX4lxBfOlUCU2LMrQtLCd0VdYp6aOYkKbKgs=
X-Received: by 2002:a05:6000:1869:b0:42b:3878:beef with SMTP id
 ffacd0b85a97d-42b4bddea9emr6141017f8f.61.1763031390463; Thu, 13 Nov 2025
 02:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113104053.18107-1-puranjay@kernel.org>
In-Reply-To: <20251113104053.18107-1-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 13 Nov 2025 11:55:54 +0100
X-Gm-Features: AWmQ_bnIvujod4vY7vdkRUSoG9i6kVzodlxqdDiRND0VB7IS-U8H4Z34w6g1bmM
Message-ID: <CAP01T77Rr7j9ySowwY=Q6avEJRbV=ehTr7+HMSfPfNrzVD4zAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: verifier: initialize imm in kfunc_tab in add_kfunc_call()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 11:40, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Metadata about a kfunc call is added to the kfunc_tab in
> add_kfunc_call() but the call instruction itself could get removed by
> opt_remove_dead_code() later if it is not reachable.
>
> If the call instruction is removed, specialize_kfunc() is never called
> for it and the desc->imm in the kfunc_tab is never initialized for this
> kfunc call. In this case, sort_kfunc_descs_by_imm_off(env->prog); in
> do_misc_fixups() doesn't sort the table correctly.
> This is a problem from s390 as its JIT uses this table to find the
> addresses for kfuncs, and if this table is not sorted properly, JIT can
> fail to find addresses for valid kfunc calls.
>
> This was exposed by:
>
> commit d869d56ca848 ("bpf: verifier: refactor kfunc specialization")
>
> as before this commit, desc->imm was initialised in add_kfunc_call().
>
> Initialize desc->imm in add_kfunc_call(), it will be overwritten with new
> imm in specialize_kfunc() if the instruction is not removed.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

