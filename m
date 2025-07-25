Return-Path: <bpf+bounces-64387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B3B122F8
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715AA1CE0835
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ECD2EF9CE;
	Fri, 25 Jul 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ/WwZS7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD55C2EF9CB
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464352; cv=none; b=Kux3yWbAPVsn1YFUh6ce76ji+Cajujca8Bi7FwpTsSdF8Q/NMLpfZ6SkuXi7BQ/ki9uRu7jU1enQdOftRm07y8Fc5BjtyINC01okf6p5r7MdvlQSicm9AroFgYLdRJyuJ8yN9xsTRpBh01XxVzs24hkJeix77v9XHm0cACkCAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464352; c=relaxed/simple;
	bh=1s096iYTPZxkFU0+AHhVGvb4tjWu7/ltAGFdu1iPAds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2Sa2iI/88nFHKNkTxbHLWUzFaccVIqIkHcrIK8zDw1AgiJSHFvyQ9G/XxDtm6fQcHysIvIQtxKzzdk7JPxJ3FG7FSwivkjwrc1ZWeWbAPq9xG/mbrDlOLv+/URiuzSl9r9/x5Y3Q7Sud73ZcU/ffZimLU/MGKde7/VwOA88Pt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ/WwZS7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3f7404710aso1309661a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753464350; x=1754069150; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1s096iYTPZxkFU0+AHhVGvb4tjWu7/ltAGFdu1iPAds=;
        b=cJ/WwZS7yxLw3IynjudV+Z5lFVM4fRUVrDa/Fy4aykyEr+hEoCcWfSSxxz0sJvoTrO
         HeRVRk6bQZ1w50Hrjwh/WbfEFP82/jirKHs6J7qN5O1PQVj5aIt3WCgPlS7Sxt4Qgail
         FZuQLScuWzpHMwe1ezndLQjn+rFCcCPuqL7JHMmrXFTEIeRE8fs6vMSMICbc/w5XT2H1
         dMH0LI4RRNjl90yF3DzNlqPlKhfPhntpb+7JKitjDqxxQdcLfipWKEidwV4usy8X8uJj
         2Dwu5VYt5SVWld08Z1ArvYB8wIsnx3WyLWwnu0lCJCVvgOLA2ivuUdf35dx3ppemPVhM
         ACWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464350; x=1754069150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1s096iYTPZxkFU0+AHhVGvb4tjWu7/ltAGFdu1iPAds=;
        b=BldxjwMiFtZtIgL6mtEVkJnbS/KVki8DS5OAJGatyojHLSVdPy+hiop3NbHq97wvb4
         g0VVrxlcGYSZTxnkf5ngZu671GquCoB3PS4KzQIdYQmXttyNOermMCTx+zIccJfrzHoI
         HrXhDKEKCxCF1SG7AoPnrypiWTxiCdRfoOdYW+mdtj1RNqgxk69TyYW/sd+Alp/9JGtN
         tgQvDgYLDcuw4g/Igah9JcDd/4Rb58BZdmCgHGXq1kj2Wm/jA+jRMCip1p83ryY6A8xu
         FFOrIremwMhm+uTj9f9XsjXs2q8JWGVgWoUf0NBS5Mb03ZC+Tkb+h9YO1r8hr5+IdMG6
         laag==
X-Gm-Message-State: AOJu0YzZxmCNM99JTRRPwpbxlzP9zJsWIq8ls1+raYLZlIMNqi/cKGBS
	NypAhE7Ggbli/gds7iR5KhsOFVT0vKgsNlQwiln70fmwv+eqE+z2hPLp
X-Gm-Gg: ASbGncs7w2LCJcLkDRP4h99R3/VLSaU9bosbO2F2kL459JDQK8e/D/4fYl60LOk4lEU
	9DNSigzTjPn/YSDQ2Nek0HKRYz3O+e+WZ8z0VCQwYh51dp0xfyr006XCQVICw0CyiDFYdSAJzWR
	Oa8YpFRiWrPC/c9l7pfakoc19JnPEkTxurYaUflRtZOpLsymM2UQH5G14/QvzdtfFehYsGTnQEn
	v0L9Oh9gEqd+cJ3Irlo5/slPXVqJrmQENH2Cjmzl/MaGrxv+tmMs1qeX+7jXB87OYMa/178Obt/
	BMQjpZGutJ/p/wn95937yZU6G2LXulQKVJ26kFw37K1DtTjyAUGVBXYiCc8u0pGElBbr7mIbmTU
	x+3GNWYlR1mszMpdX1Q==
X-Google-Smtp-Source: AGHT+IH5ygbI+JMHFy8ezU2ZJmTEnAl5vH4dxec0+y6N7jHjFpt+ZuAUG0ElDgy1J1Ef4tdto1re7A==
X-Received: by 2002:a17:903:46c8:b0:235:f3e6:4680 with SMTP id d9443c01a7336-23fb308523emr43884775ad.21.1753464349981;
        Fri, 25 Jul 2025 10:25:49 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe4fc820sm1577165ad.84.2025.07.25.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:25:49 -0700 (PDT)
Message-ID: <be4f3aff20e66f5025b848d25477b709e37b6fe9.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Simplify bounds refinement from s32
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Paul Chaignon
	 <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Date: Fri, 25 Jul 2025 10:25:46 -0700
In-Reply-To: <nrsym2fuoeqoewmf7omq5dr2wtnq63bmivc2ndvkybi3xh4ger@7fenu3fa566i>
References: <aIJwnFnFyUjNsCNa@mail.gmail.com>
	 <4da44707e926d2b2cb7e1d19572d006d7b7c06bd.camel@gmail.com>
	 <nrsym2fuoeqoewmf7omq5dr2wtnq63bmivc2ndvkybi3xh4ger@7fenu3fa566i>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-25 at 17:21 +0800, Shung-Hsi Yu wrote:

[...]

> Beside going through the reasoning, I also played with CBMC a bit to
> double check that as far as a single run of __reg_deduce_bounds() is
> concerned (and that the register state matches certain handwavy
> expectations), the change indeed still preserve the original behavior.

Interesting, thank you!

