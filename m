Return-Path: <bpf+bounces-30869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D0E8D4077
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB5B28426F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 21:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33F1C9ECD;
	Wed, 29 May 2024 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7naJH2q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A081C9ECA
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019198; cv=none; b=HNecBWEsNBDgiCGabeAiDcoEMkfolmb1Zxerg5Kj9sbMScQyUm1r7FWGjs/+NnDsSVAsEiDSLu5weKx7TMepA+NxnBVq+7piSGC7Afq5MpcRbbim3NEtXO42UDu7fpQ928jC28YqAwiSSnI3B2auSmUJ9QJYAkFeshDFdSlBn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019198; c=relaxed/simple;
	bh=7jaefe1N/tE42Fs/S91tAgpLXqYiFZFDuRWpoKVJIKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxQtWduuf8b4tfpc+VTj49ni+oEJS0GzuoGevbcbxx8GtSudCmuBfDh2/Y7e5tL1IeMR8W3sgHokWwRyv5KR0jqnylpp/TQ5h8I08v27wxZLHBKWm/hzfGMRetDN/sU2PbDwmW1ko1alyEFQ8rcFOfcmm1W4pYwxwVYQER/6P3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7naJH2q; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62a08b250a2so1476557b3.3
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717019196; x=1717623996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri/kgtJvemd72X4aLblliayOBm6ynBRRD1uuOZ6o6ZI=;
        b=e7naJH2q61dpKU/xg2m4MA+hKnJKEqAl9pT2qsQXEOnqaqLtfdIX790TrxjCy6Nehd
         8S57/7Z2n0tvtwXWvNo3fzIv/VM4WF1t/jdlVsBK/Pm3XdsQsq2W4iHcK9imKEH8u0Bz
         9JoLDjD8udlMrTx2LFzjKTTxCuSNmNd7Ib+BxGRKj4XaUaKOGos1mpyeImc2fdgruum6
         H0yVieEFYyWDrGTwAPICcvOqxRqihwEHow0InUw62h1sUtiUv9K+lIsqPAr5QfUfzRof
         uQrJLoDybZIoG+nTazs33KfTnUqrcfGbnsyb6X0rwQJOv/o1noSg7ml5LiDjge/9XgB8
         PxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019196; x=1717623996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri/kgtJvemd72X4aLblliayOBm6ynBRRD1uuOZ6o6ZI=;
        b=Sq/GzqA5t6QeIBwDm16vn1tZ7QAzCGM7KKneOxk/EUQk7xPDdYjUwgm2e2Oa7zAyTJ
         mUEiRMzA17ltVhSfDrU115mhrm0cdNKNuknAjKYCKXPtKunDYEzcHhY8ELVihdljLgPi
         nyXeRsChQiNaoTR2lY9Rjq3grOooRLo6I9wC2Wx412dsFQ64EaESigge2FwEitGVsqOy
         z0RJ5+ladHcZA0ZDcuAXcFzb3NgJGS+LQ3A2PDAUfS+MK6wo1/vR0XyTHVsSHprl5rIG
         /DtK2V3aL/DN10ZJw2LIbv/7oAkCxEkp1kQ9UWscnJEUueTpH7aTrx5nI2MsC4qgSbxC
         YfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2J01GNVJAjes1MHjPJNwItV+nHzLhOmGQF16DKpm1Txn9wWvH7p6lRbID274rEp+biJcZ8Axx9OrSH6JZ//nQ93Ke
X-Gm-Message-State: AOJu0Ywmqm9JA2LoPcuipUMMBnRsS4ShwekLcCsR5dHkDZdK4iV2hE1w
	/HZHTylE7hzKbuQpXzwn9xAbMVWjFr9/z10KCx0Ou7ys6oyF98fIIPKoXZas4LVqxpYMFKOGk9k
	MKOtGuOAeGX37GNwMmAhfplDYao4=
X-Google-Smtp-Source: AGHT+IFyj3bfZSUR+7gtGA6biYLqOYnCWMRT2Phmux7Y9DT2BmJLCnSgzO4+/oMqa0J1sLmMDs/2k50AonZtGal2+gc=
X-Received: by 2002:a0d:d1c1:0:b0:619:da17:87be with SMTP id
 00721157ae682-62c6bcdbabdmr3657867b3.42.1717019196062; Wed, 29 May 2024
 14:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axP3gGsdQC+CYXjBCxk++9U5upfmBAK2g9=ZNnD7N8tY3A@mail.gmail.com>
 <CAADnVQK1tA3cjSwH4GK81R9rkVG=y_aq2a4gUw2mkUn0G8OT8Q@mail.gmail.com>
In-Reply-To: <CAADnVQK1tA3cjSwH4GK81R9rkVG=y_aq2a4gUw2mkUn0G8OT8Q@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 29 May 2024 14:46:25 -0700
Message-ID: <CAMB2axPh4T-8yH-S+BryxQ3vp1Cpjrf1Zgv8rbbo2m+zRML+Dw@mail.gmail.com>
Subject: Re: Potential deadlock in bpf_lpm_trie
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, pgovind2@uci.edu, 
	"hsinweih@uci.edu" <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:20=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 29, 2024 at 8:53=E2=80=AFAM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Hello,
> >
> > We are developing a tool to perform static analysis on the bpf
> > subsystem to detect locking violations. Our tool reported the
> > spin_lock_irqsave() in trie_delete_elem() and trie_update_elem() that
> > could be called from an NMI. If a bpf program holding the lock is
> > interrupted by the same program in NMI, a deadlock can happen. The
> > report was generated for kernel version 6.6-rc4, however, we believe
> > this should still exist in the latest kernel.
>
> Fix it similar to
> https://lore.kernel.org/all/20230911132815.717240-1-toke@redhat.com/
> ?

I applied the similar fixing approach to trie->lock, and then I found
the two other locks mentioned earlier. My feeling is that there might
not be a use case to justify doing trylocks in memcg and rcu. If you
think the approach below is okay. I can send a fixing patch.

trie_update_elem() {
+        if (in_nmi())
+                return -EBUSY;
}

Thanks,
Amery

