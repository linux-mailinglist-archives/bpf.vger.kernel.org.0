Return-Path: <bpf+bounces-32227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F952909915
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E85B282926
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9649653;
	Sat, 15 Jun 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKC/15iG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA818487B3
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718470807; cv=none; b=Kjbj0GNVpvFA8USeyiKUUJ8a2hszPjvbJ/5x4aCe2FaB3Jojq3nGZDOEojhoKccdAKvITS/DwjeA1TN4iXme58WA/NgRidlSSYQcfQkf2ShmuMh3eU7FkSNV46eQNVOCEPu1KdLqMgZ6Aa2PNsk0rTkOygI0k6zsptphA37FHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718470807; c=relaxed/simple;
	bh=Lc+UQPuZuWU0IFiT7V2YQR8T2ODlAtOM3/uuXJ8EBFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shT8cq67ga7mQ563r9loneroNKgg33BOZQoisLepblKDKKr7+dKdLXEtAqluqMkWvHRQkVoC8UOwFrXPpd4BgQLJKo6Ob98CBaKOEZo55GqzmjpJ2u3UQ/kHpzmJGTVb887b3WLmTwbZGnhOdEgZOjQ030I3fRU6Psmt7OOULtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKC/15iG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3608e6d14b6so284076f8f.0
        for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718470804; x=1719075604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc+UQPuZuWU0IFiT7V2YQR8T2ODlAtOM3/uuXJ8EBFs=;
        b=cKC/15iGeTJa92uK7b7F4tVNByLXQtm1xlmNRsv7o9sB3ytcnqWoyq56Z9toWM4jEm
         Z6Wq8irOWeTKDB85xghD17KZZ1Jv6Ky61HO/YwUfml6QYsngiTqmXvWa9eFJ2nbkPUoc
         7eMAfwNl3PnoV3/1UMfL+P22pY3QE4nysuqMubhNwpCaf20itPLWx8d2sSykRygMksOg
         CeTO4ihT9l5A4a1i67icupnHySmQS8UzJ39KJMjnl93X5nSfnXdaosE9GXRm9UxXgx7O
         Qpo9eIbW+69CNcovmXsFIsSIXWVO/ShRoKeOyZ5EsaNl5K+uJGUd4ERQs3HGqLfxO/9Z
         Gayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718470804; x=1719075604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc+UQPuZuWU0IFiT7V2YQR8T2ODlAtOM3/uuXJ8EBFs=;
        b=i5kb1qdpRwO4QTq7wgWZqfVq87r7bm++OvEz1rugw4yzMoBuCVmvR9iSCUDOopvKLO
         zppZ/VZVA/a7w9Cy3Xw6Mj9o91kKLAZ1C0rtJ/qZ9k6QO+xlp5yXloQr3kiAWWUfQj1F
         ++4yCgcikcTtPyplTldh/uyqZTaLlE3lKk96eEMOFxKBICC2oHPT1DUlXgYlL6q47Ue3
         v8KN2yvZPyAlitXxGF0qHIR6TBBdvFcZrOru66gdr3ks28vpRvPpNdX/+JR0lcv7phaq
         39lW0uQe0y52dbAw4fZCnX0X7+J12JwHiTkf5c2VIaDNY36pYuuta3bqyWWFlnmeTe/y
         nfJA==
X-Gm-Message-State: AOJu0YxD9wjhrLcZDNqqw09jl3I2NZGlVLGCrbeqQyFu4OUKjx/UnoOb
	Er+IrJkM7rOR3VELYVe2SVvID37UjIuaVG0yp7/gGUQtCNgMWLkL+CCeCje/OjZVAOllpATXEFe
	CSQbilXwpektvuJME784mJZs2heE=
X-Google-Smtp-Source: AGHT+IFb/BCQyUcj9e1UUU1qu+/hiuAuqOQ6bJTD/g07YpDn6UCyWZ7ORd8Q7lqhAIn6T8MueRG5S8S8x21NJAidYKw=
X-Received: by 2002:a05:6000:bcf:b0:360:86ad:7a6f with SMTP id
 ffacd0b85a97d-36086ad7acamr2796334f8f.48.1718470803766; Sat, 15 Jun 2024
 10:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eHjqF1DbM2cbq_nXVoanIt042aeSlLwf3xBQ-LTesttfagbXyJfsxMa1zyHU6ngtUYRD4-nfM3sAmyRbPiSN7o4_sWtRy8zodlI7K2UmyTg=@protonmail.com>
 <CAADnVQLPU0Shz7dWV4bn2BgtGdxN3uFHPeobGBA72tpg5Xoykw@mail.gmail.com> <-P_rTwSVX1lEiqRGA2drBZcQM24fbnVw4OBcVUrZ4bwPHBQ9QhFHJeWrHmImV3UxR6YqbRdkKXgVHHfNck-54u8Q0QSK6Qi4EWzxr9PVPSE=@protonmail.com>
In-Reply-To: <-P_rTwSVX1lEiqRGA2drBZcQM24fbnVw4OBcVUrZ4bwPHBQ9QhFHJeWrHmImV3UxR6YqbRdkKXgVHHfNck-54u8Q0QSK6Qi4EWzxr9PVPSE=@protonmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 15 Jun 2024 09:59:52 -0700
Message-ID: <CAADnVQJU30G1DezPLTzGyOSzG5TU3Tr-ZAoL+MYFEE+WKLD=2Q@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls related to ebpf
To: Zac Ecob <zacecob@protonmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 12:09=E2=80=AFAM Zac Ecob <zacecob@protonmail.com> =
wrote:
>
> > I reduced the reproducer to the following:
>
> Thank you for minimising the repro - I didn't think to do it myself. Apol=
ogies.
>
> > The verifier doesn't process the (s8) instruction correctly.
>
> I took a further look out of curiosity and managed to properly crash the =
kernel. I think it might have security implications?
> I haven't attached a repro for this because of such (though I could perha=
ps email it directly?).
>
> Not sure how best to precede?

Pls focus your efforts on fixing the bug.

