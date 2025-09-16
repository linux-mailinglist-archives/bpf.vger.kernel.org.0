Return-Path: <bpf+bounces-68501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A954AB5975C
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C4B1BC16F9
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C4307AC6;
	Tue, 16 Sep 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7SMMss/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8A21D3DC
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028815; cv=none; b=NfcLlGzXnjTlxdYhd/3o27CaS2Aaw9CbR8tN60SWcUSE0NqASJmuGGzHcMK2P4Uwr6oaMnAD0iFk7VMdk2Br+sQsbXlu46bNvudBXeoJZd+wHpka0pFuexfOamnMclVyXdbLGFM8JNOWPu6ELX59oLZAGsjpD72ZNjCqoGgGz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028815; c=relaxed/simple;
	bh=aDoWWsyiIlNC/dT/ClWf39o/rzAfbdapphOPB3tSZaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G80J3zCxlOJhpRcBdIQP2DDeVcVzJduMfcUbKWhoH9i6vG9IaElqTJ3xa85vSgglEXdb5cWBXMnI/TMt9C4iVyGpB62a81BPQCpJr38u5L2akfU0pGYhwLckkgtTk10Nv3iWhMk33tdk+8xRFIUu46fhq5/AJiP/7r8JUrTWwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7SMMss/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B43CC4CEEB
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028814;
	bh=aDoWWsyiIlNC/dT/ClWf39o/rzAfbdapphOPB3tSZaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F7SMMss/ZEBPPCQZBjetdtcLFxovVkjO7sgZ23zVhOGsdBspwowdjIF5cXFniFIc2
	 qRi1+wLpMAJyZ+7zXOIE3eIQMuCa2dHVeU4nKKTMuD9O2ug8zxRg2GjjrTmlmxMyrS
	 Pkndvgl8w+CiTdzEOFoziAXOgfOgGKBrjRdc/zr//cyy3dzCIj8iV0RY4EBtM4eE7m
	 t9CP6Zt0EaVkFVOLaRLQPoQmzzAE6gwQHC5AJfmmoTvTQIoj6KSno2CrXenZA7rCzy
	 nCBKk5w8dGTaN5EFiZzxpodLCx5++AAj7W3LvbqiIggNSwqL9CmMilVBEXvzuV9BWb
	 R9iNdLSf12esg==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80e4cb9d7ceso703174285a.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 06:20:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXRTcC9Axf/SgE3NVSNUwe0kjvsCmcmJ+G4/+Zvi6Krk7nqY9bxUlI+zhEDqMd58zKEgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILra0Ze1mnrSRzHWNdW+LfUeY41CSsb7sbLEMRDYTpZpwp/yJ
	ok1GEGxbzmY3jlBz0aIrId1MhTC55Qv91vL5GMiWo3Lk/jJ4r3i7DXDgm7hRrnGnEw07/fsGfHx
	0Y9jm1gHCKRcpR6yl4xE+FHyOAXN44vQ=
X-Google-Smtp-Source: AGHT+IFiBRMTZxoiPL85+xhnXYXzT2oMuwTdGC/0/EJsVR+12CkscuEMn31v+IHVfDP7g1za7MJcl/JSaAWvhdXYVIw=
X-Received: by 2002:a05:620a:199d:b0:824:aa47:9901 with SMTP id
 af79cd13be357-824aa479a40mr1685191185a.78.1758028813709; Tue, 16 Sep 2025
 06:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915120148.2922-1-magnus.karlsson@gmail.com>
In-Reply-To: <20250915120148.2922-1-magnus.karlsson@gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Tue, 16 Sep 2025 15:20:02 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNg6WsVbGXPooZuQqEJko5qBWWpqBxOYpiE1QqgjKoDFyg@mail.gmail.com>
X-Gm-Features: AS18NWBsvEAJPW-f4HR_UWhcPy0zTpCgS6KVoWYY9IdfArS2v2h7PhwJRUJTG74
Message-ID: <CAJ+HfNg6WsVbGXPooZuQqEJko5qBWWpqBxOYpiE1QqgjKoDFyg@mail.gmail.com>
Subject: Re: [PATCH bpf] MAINTAINERS: delete inactive maintainers from AF_XDP
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Magnus,

On Mon, 15 Sept 2025 at 14:02, Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Delete Bj=C3=B6rn T=C3=B6pel and Jonathan Lemon as maintainer and reviewe=
r,
> respectively, as they have not been contributing towards AF_XDP for
> several years. I have spoken to Bj=C3=B6rn and he is ok with his removal.

About time!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

