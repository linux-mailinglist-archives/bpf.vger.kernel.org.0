Return-Path: <bpf+bounces-18955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88B823842
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0448C286A36
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF41DA2A;
	Wed,  3 Jan 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brown.edu header.i=@brown.edu header.b="h9J6wXlQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3931DA54
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brown.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brown.edu
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbd990ad852so7190452276.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 14:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brown.edu; s=google; t=1704321530; x=1704926330; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fRnKGzlLoOgWhNE88nvhL7G8XQz2FdhxBl4CKfc9DQ=;
        b=h9J6wXlQaXERMvTRUWIzYSOnj899zGm2txbVUs/wBFb3Ah448vPOWQR3tUavzSenVH
         /dU1A3XzRn5lHsRNR3LrcBeZMwbxY2ikqwhflVePSpDiaERaemLdiN1SlJLNiZWpZ9Ka
         s0tpDK+I2gv+IorpsXeLIZvenYJ+gnsv8p06EgSiZ0Cx0FhzFlroscKWlWjPNWK9J11P
         VbGyOMFeez8+i9z7rdTbuOAarEta1U3aLpebq2eS+zIHMZQzv5VrStbJ722opeeBb3Bb
         4c9WNJuzUULE22A7u7wqNytgDfUh0Dp0+jm/y1i2JtCsavWhfAT52H3Xg+98Tu9CnACi
         MVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321530; x=1704926330;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fRnKGzlLoOgWhNE88nvhL7G8XQz2FdhxBl4CKfc9DQ=;
        b=r+qgbkSwj/V2sybtelTylzJ5xQctov++xQndUxyaCicXogLW2+m3XgLlg6pOcwkCJ8
         fm4sqMRxhwNORLJ8IQ2wir3leR17mJ2pRNwq3ZQztqBDbN1GskbriXPVU2KpJZ68thZB
         kalk8UyrDfBfkPE6pdC7UxNdSU6c9X1qi1Vou8UlquBzvFoIxxrTdqVwl1lBLpDdPA6E
         FWO1Wk62z0Ee6LExBQ3BpHpqZca92DpolPfRzfwuhS12sRDYcDzysL1klNn/b+eIjBAb
         vF9zdOeCy5W4btrevMMvqig6noF7oZYIBwXJqE3nK4LEQ5OJSI3zabkEfSTDTJPAYJDV
         0i0Q==
X-Gm-Message-State: AOJu0Yw6YtgYlf0mcr+WlT7RhahCKJ0HlmAJAwHQENMxDL5eHvPh/1xq
	3vu+MXE8ipSHHWvJRBCrmDJOetIERLfYoCduTex4b0lhVXJUm7Hhq5nR5dPEGw==
X-Google-Smtp-Source: AGHT+IEGL6XYfCMN4aoDjpH7WtoOunzE0trRG2cxaSgmGL//o+zYOGmWVud+eDMowFJcDLhs33Owya189LT9CrxN3Qc=
X-Received: by 2002:a25:b910:0:b0:dbe:18e9:dc3a with SMTP id
 x16-20020a25b910000000b00dbe18e9dc3amr7209042ybj.101.1704321530107; Wed, 03
 Jan 2024 14:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYZPR03MB679243A8E626CC796CB7BDBDB461A@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
In-Reply-To: <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
From: "Jin, Di" <di_jin@brown.edu>
Date: Wed, 3 Jan 2024 17:38:39 -0500
Message-ID: <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com>
Subject: Fwd: BPF-NX+CFI is a good upstreaming candidate
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: Jin, Di <di_jin@brown.edu>
Date: Wed, Jan 3, 2024 at 5:19=E2=80=AFPM
Subject: Re: BPF-NX+CFI is a good upstreaming candidate
To: Maxwell Bland <mbland@motorola.com>
Cc: v.atlidakis@gmail.com <v.atlidakis@gmail.com>, vpk@cs.brown.edu
<vpk@cs.brown.edu>, dborkman@kernel.org <dborkman@kernel.org>,
lsf-pc@lists.linux-foundation.org <lsf-pc@lists.linux-foundation.org>,
bpf@vger.kernel.org <bpf@vger.kernel.org>, Andrew Wheeler
<awheeler@motorola.com>, Sammy BS2 Que | =E9=98=99=E6=96=8C=E7=94=9F <quebs=
2@motorola.com>


Dear all,

There are a couple of noteworthy things about the patches:
1. They currently don't work with CONFIG_RANDOMIZE_MEMORY, which
should probably be addressed.
2. BPF-CFI tries to ensure the interpreter starts from the correct
offset under code-reuse attacks, which means it needs some form of
control flow integrity. Here we are enforcing that with the state of a
read-only variable, which is toggled by temporarily disabling the WP
bit. This also introduces the problem of having to disable interrupt
during the interpreter's execution otherwise the variable will be in
the wrong state during interrupt. In the paper we optimized away the
toggling of the WP bit by some trick involving turning off protection
like SMAP during the interpreter's execution, which is faster in terms
of performance, but the security trade-off is a bit more subtle. The
argument being that SMAP (or PAN) are contributing very marginally
when BPF programs are being executed, since the things they are
defending against, namely user-controlled memory content, are already
present in the execution context. This version of BPF-CFI should incur
almost no overhead. The WP bit toggling version I don't have numbers
at hand.

@Maxwell: If you are not in a hurry (I will need a couple of days) I
can generate a set of patches that are compatible for patch submission
(proper name and email address, signoff, formatting, etc.), during
which I can also get some performance numbers. We can discuss
authorship depending on how much you want to adapt these patches.

Regards,
Di Jin

