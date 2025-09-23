Return-Path: <bpf+bounces-69365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D95B9553E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2337AC2C1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A93320A30;
	Tue, 23 Sep 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSCbgL/Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57904258CF9
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621144; cv=none; b=g2+Ah+/KWvUGswnXvyP8GpaLWRTkB6CdLyOUK88OxFmZJfgDnr0cBUo3v9tsr9ycHgdYI+UuXwh4wc3k7Mh4Ynu/cbAdvKDvD5ZS7FRIuRL2MTdn+Hznknu2KXrb6hpaOZMISFrcoXQE8p7sWzdIufx+yLzQ3scjOFN8XDpb5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621144; c=relaxed/simple;
	bh=E110EFHk2snli7qzu3U7zBFvZi8n/Y++QmIK2DM15hY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ROj3QHu93NFTSuJ6fdRO9W2UbTJezAbFsTIRyTI1WaI1eBxSaSxrSxVRht6U5Bh7Wbs0d5ALkUWPomdWeHJx1bbfu6ok+2j2+A/N6VjKWZzzeWYqcJG5ODrkLQQQ3Ia+6+go8sAm3xNLEhq2Ns4s5Wv35hvEFie/duc9QWIPXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSCbgL/Q; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7939ac99c29so255638a34.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758621142; x=1759225942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E110EFHk2snli7qzu3U7zBFvZi8n/Y++QmIK2DM15hY=;
        b=WSCbgL/Q4mvgf43RcQHJriAs57wJ4dXfSwGd3nK2madHVeagu/hgpH+j4Pm6gZLZhH
         gIIiacxIezSN/ItXCeICA5xTkoQLIwyyefsqtBmWtxmcRnp69duDL4uWvMh/jrJJbzu/
         J2N7cfjMKp5iWM9iYfIKqUkNyDJz4KQswXY/PWjd7/Isv0A9/KfyNmRTVyzag7SpF7FT
         luTZlpiUp6I8i7TDa+Qcw3A9d5NjsJxo8zwG5nru7mRIBHR4H+ghgaAQlCRmJ4U8P3Sg
         iVr4AAkYrISjoAE7YEQzj+rSJogK66GTK3+3z5/u/UtUfANYVZ8vF7AjH3cHyYQeozpL
         WCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621142; x=1759225942;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E110EFHk2snli7qzu3U7zBFvZi8n/Y++QmIK2DM15hY=;
        b=Wc+A8DQefRQD+MAFu3h23y0irp2HfT/FXz7cFhFUXcr7wly1gqm6jhaq/jIKeM1Cdi
         QmXxDDPLCTpUPEiEnNJlvOsL/lSuuqFtUyQXTbwmZQ1RyVjUcZTJSFs8AUIQDMf41XVl
         4vL3NzGqmzXdpmKSLCBOf+u1vjOn9QFHAoUudJKkLL0ZgItrbvHGFJQUJmeicqVBzzhF
         2YcbsAzHLqQYyQ6HuTNmGf/wtuY6MozcPTYyqyBYgsGPAVYIdJGJwNRgzEgRUlXQQajy
         K+YowfaITRSidK190qh4HRTytVNfziuzVL+dcbyw4csb9laNxRusS/+DMSR5yezWKwK8
         mNhg==
X-Gm-Message-State: AOJu0YzWdUuVURgmwJCqMP6aCuilNfDBsXLAaUctbXCNPmouDkPe3rqV
	fO1vTHh5w/waivfEHOxby+cVWDfT/OguhBdD7ob6GjheBSpYb/4LKLXRwLo3PdWGVeYToilcupn
	ImdrcfIW0N4e/NqvTJ7h1MRNGIEGeLVI=
X-Gm-Gg: ASbGnctaZhvp9x8THtk7sqiCE22qK7WxO5NJyyWVd5wBF4TUBHIcYC7tM3wNfBUiUft
	Vxdy1/esW8f+XY83EIOqVVD4SeHjTSsauoY4vW7Kc5C9rbAMC/TlUye4W8hYA2zc4mkmIamkkz8
	SGByQ9WWYhQ4fmydlvmJxX9NsvmCubFPT0OPIdrCcbL+ldwwoNplrEx+mkzrmJ2hCxtQ2HdrOPq
	O9vEvI=
X-Google-Smtp-Source: AGHT+IGn9G+g9KcKdeDqAQEYD1d/WG0VVkXO1S3tVxU5Y4KEzxQ15VxhK3LS26x3q3KWY3feF3/i3eMSnIQdELizFhA=
X-Received: by 2002:a05:6808:228b:b0:43a:2e17:3ba8 with SMTP id
 5614622812f47-43f2d10d9c2mr975431b6e.0.1758621142430; Tue, 23 Sep 2025
 02:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 23 Sep 2025 17:52:11 +0800
X-Gm-Features: AS18NWD_ORGgJ4o902_F9th9fMD3Z548kXGSC1yox5XsEgpllf6iDCcPrxmfz40
Message-ID: <CAEyhmHTvj4cDRfu1FXSEXmdCqyWfs3ehw5gtB9qJCrThuUy2Kw@mail.gmail.com>
Subject: Some unpriv verifier tests failed due to bpf_jit_bypass_spec_v1
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, luis.gerhorst@fau.de, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Some unpriv verifier tests (e.g. bounds_map_value_variant_2) failed
on LoongArch which implements bpf_jit_bypass_spec_v1().

This is because some verifier paths do can_skip_alu_sanitation().
So for such cases, the priv/unpriv test cases will have the same
verifier error messages and the tests failed with unexpected error
messages.

How can we fix them?

