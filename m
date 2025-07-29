Return-Path: <bpf+bounces-64581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F8B1462F
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 04:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AB83BF1C7
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 02:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE71FFC55;
	Tue, 29 Jul 2025 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSK75bEW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BB1FE44D;
	Tue, 29 Jul 2025 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756072; cv=none; b=W+yYw4GThDLg4DJISvCLma5u+Yvp7iLJ9OqAdtfkQYuQrst5D3nVxV+JfalujR+7CfMERf8EB53I+9Xs5evlpRUq550SgN4hh8FO+vmf9kC5ghvNf40NZ733omifMQceDjy3thobnYd7plgeQ2ucHs4STUVJlw+AFODJjJoABo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756072; c=relaxed/simple;
	bh=wiDYpJvTKn/tBt1aS/imHGSW3aLNn3ZDGbCHPJ1a/X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gL9o4imXU+w3af+DYkR9sRrILgcNUZjqiHJ6M3cNoLTOG3UuAZewlfmtn3cmCB355srbUANrvruvsbLl+DLS495G7ZidIMm44S2vqVMO65GciBzYCe1exuzEKjThM8sRLfQgicXr4uA//vDAAKBWm9sWL6aZlxD8/eoVxoaFlgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSK75bEW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7892609a5so858698f8f.1;
        Mon, 28 Jul 2025 19:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753756068; x=1754360868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paT5Rnl1J+a4eKjTLjjH2rWqAOkaC13uBNJR10avqIg=;
        b=RSK75bEW6LBTTL/y2Y/V5y/F0yexbgAp8CcOYK5K9yzcfd6lFSKJdeNJ/p5ZuNbnEI
         hT40tn+e3Fzoey/Cgrkd8snWlZANyLW1L3L/pckabChbxjrYOIatRM2DVA97FQ8CgvYu
         2jzfWioCaPrduGhk/DKs6L/0pQChtcKbiIb3jTll8EBBtpqgxZHpt8WearCz/fHfEH4p
         JxYoAUBf2BWnu2MaKwPK74RudzohpZHf6hENU7d/QbdcEYvLQKWRUvLu7xOpotooC/x3
         WaxkEgkopYuxLe+2fCK0Z296xr+S5v4/HKW4FipD31XI9i2/5PrCx/5svu73+xuWOKN0
         p8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756068; x=1754360868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paT5Rnl1J+a4eKjTLjjH2rWqAOkaC13uBNJR10avqIg=;
        b=rZpK8rPcqENsVRF7SdTyi9+ZNzYx5pdU3kELIjnvCJx7x7B1CmJgttiC3PEEGw8I9z
         WZSPLbL+pnCqcS44KRJTT2W0H7eWPwg9eKOSESgqrlmvuYn3adV1Xe3z/dQjku0jZESN
         5V7d5S+rmIoEC2WgcZBSBwNJuCwQU3FQblK+mlLH9EVds8rFr/8aijz1tIGZQXI0DB4H
         Qw6XcqYWSWfBKpWJMukBA1gj68l+s0Dqjq4JxjIdb+oYVUEkFycGf5sPzGGlat+PBsLR
         M6H532Kz+qXgUzYwSbrcPL25TqP+RsZara07sOeRjANXoyvhugLpam7geq2Z2g5v0G2G
         jQqg==
X-Forwarded-Encrypted: i=1; AJvYcCVPGZiVT5U6F8R9Og0CtkRXwFflVZ1ohRiL/X/SpsLnyA0WWneIca/GiTYwfP4tcNYOykMvZ0qfyHOratyi8MWv+J3DliY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiML/vL8tV0PYbQKEglr4IWOKE6c1hu58HfsrGbVwyG2HQx0R
	9ngt1q43LR1UstSHMtmKk3ILH9l+5jZ8UmcjQP0lbqlWLDfefj/MfJRtht3FKSANCAlz/FAGJca
	57oS6766iqXkTMs7e72iXJU+hFpPrvBw=
X-Gm-Gg: ASbGncspuf5huTn6xbuDy1vFozHGgET+kay6mkpjIUkGNstk9MtcrevSO73K+pwPNJ4
	p8LR3TOlV8rWNZu159tfId9+c8+rkCKqa+GUKmIv3EMRc7W3pOEUuhAnqp7NJJo+B7fPuVoVmOM
	/KyJV0IJWl/jK2sdOtM9T9Hnvx7gvUWlSpVgifutu4/7AOCLnb2dTo+q9wcDyBw2ptLd+YvB2JT
	42zKnsxyfJSvECluneragLcYJA9953uTYwRL/R+6OVJ6yg=
X-Google-Smtp-Source: AGHT+IGhMxEyIpT5LMGOwNnOBctXTZO/pkUpO9LC8ScFvb3AB4MCPcybJ1b2EN4YGzc3H/3kv/8sY1jsIgbmROuSius=
X-Received: by 2002:a05:6000:250c:b0:3a8:30b8:cb93 with SMTP id
 ffacd0b85a97d-3b77675bd64mr10065474f8f.32.1753756068549; Mon, 28 Jul 2025
 19:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-13-kpsingh@kernel.org>
In-Reply-To: <20250721211958.1881379-13-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Jul 2025 19:27:36 -0700
X-Gm-Features: Ac12FXyHeq6W7E3xVN5SOuF-CODJBk3zwpkYsyutA8l2JaFtsPMSEFehaIlEC48
Message-ID: <CAADnVQJ28MimhbBKr6ck85zBVCa9vf96aZzq0H3ZOQ-zvgzWxg@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] selftests/bpf: Enable signature verification for
 all lskel tests
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:20=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>

>
> +LSKEL_SIGN :=3D -S -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
>  TRUNNER_OUTPUT :=3D $(OUTPUT)$(if $2,/)$2
>  TRUNNER_BINARY :=3D $1$(if $2,-)$2
>  TRUNNER_TEST_OBJS :=3D $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,     =
 \
> @@ -601,7 +602,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) =
| $(TRUNNER_OUTPUT)
>         $(Q)$$(BPFTOOL) gen object $$(<:.o=3D.llinked2.o) $$(<:.o=3D.llin=
ked1.o)
>         $(Q)$$(BPFTOOL) gen object $$(<:.o=3D.llinked3.o) $$(<:.o=3D.llin=
ked2.o)
>         $(Q)diff $$(<:.o=3D.llinked2.o) $$(<:.o=3D.llinked3.o)
> -       $(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=3D.llinked3.o) name $$(no=
tdir $$(<:.bpf.o=3D_lskel)) > $$@
> +       $(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=3D.llinked3.o)=
 name $$(notdir $$(<:.bpf.o=3D_lskel)) > $$@
>         $(Q)rm -f $$(<:.o=3D.llinked1.o) $$(<:.o=3D.llinked2.o) $$(<:.o=
=3D.llinked3.o)

Does it mean that it makes all lskel tests to be signed tests ?
It's great that CI green lights it, but imo it's an overkill.
Let's have a few signed tests instead of making all of them.

