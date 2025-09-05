Return-Path: <bpf+bounces-67627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4336B4658C
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEE4583656
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A592F0696;
	Fri,  5 Sep 2025 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXjOCics"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E92E7651
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107909; cv=none; b=AMfm/l4n+zVLWRF/nmuR1OL5AWKLi1beuug+wqnhuKRvOdcakYAQy9BfODGhcDeYGEAa6H22NiYTt6XlK6MQpLdPAAxvyBqmPdR55wXLt0mmRx4WhiCkeZ5EmtV0JL3/AAQXnRJ+QAH3WR+6MyzvwDYWIeCa5WBHOvLZpAtJh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107909; c=relaxed/simple;
	bh=Kg6TAzD2LZtVAHpNY4DJGCly+hgxT8K2FwByy+402n4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKGv1WN1zBYvQDGBD05fvMbYAJNLPaYDpD4WEPasWnklJIHSwy1FlY81RMr87i0w7XwHBmUldo5npDB+6zQE1Cg3pkoI979t4EBWv5/zeI96YjuvroMox7kqDk1wlgbtynBnvhjnYWtmr274YehUb3T5mlO2XIHtcOCJYlGsE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXjOCics; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-329e47dfa3eso2299196a91.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107907; x=1757712707; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kg6TAzD2LZtVAHpNY4DJGCly+hgxT8K2FwByy+402n4=;
        b=GXjOCicsc34Wq8hunl4t18mc0HL4ejr3iPd7NZyHgwN2xKUTPUbE5y4hUCSNJvSi2X
         w3QjWoWHWtHry7kyw9qqE11YCucT8bjMEwD6dZN5F71grvGVNQE6e2o/3EuXPDXUspVr
         OGFnqeSvgKWtHH360i3/SYInkh8lwV+pyhdpiyaTHdQKxHmbrGqvuJ8porj/xD08PEhj
         P7Ao+XGMb8LO1XDwYMfowCBWmE9FiQqOz0goFgcQvBT31IpMvQZVAe7Mz5aeDWSz1X0L
         LQGPfSQzlI2BK8Zn0nUKYFmLorNKVBLYk/cyDmKpHi56ZSu/qzM34UhlP6qdbNAEBguf
         glow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107907; x=1757712707;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kg6TAzD2LZtVAHpNY4DJGCly+hgxT8K2FwByy+402n4=;
        b=Lt1VZxiK+Cur4ASCdPKmGiYI2k1ojSGXQdnpC5s8HlpyB1STht4+VpjksAd4RdHm/Y
         oDfcrmHvL0WGUq1lgtLUpW5Qs7+X+SqJ5nhU8oZqLJZXt8RFkaXvYgtO2Ow76CWD9q+Y
         GWwRuFWoO732e0wZzSi6++AilsyvLO9gpAGCOvMDUg+3NU/l/E3vgMZg9xWbhzzTFvw5
         S5UFxDA1UgTrZT9hAZNzyHY7NEMO/q2D+x9zVnoQWde94RwjlRQUrsiGSkyc+yibGexg
         VaRydlzl1i1RCOzAyZHFCkBzDIo0Qr4cOJJa3pcgZiIItpMdG0RsPTQO8FDsH//xtNCu
         A5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMc2s31uLoeFYqS+YqRBipIAtjcACXxse57U9fb4VIZ2jvWZHA9ZkTRQP+S6hMsgFzl9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+1A2EU+0mysteJ7S6RHd3BlGcUDMP0sskBS7d/Wkhdkzzjt+
	rQ4gmvWxhQG4qX6IZuqZWkX5hY/3xNTjEq2zcAyqNEY717DULSfy7ndaGCirbQ==
X-Gm-Gg: ASbGncuQbDwbplImV1WICg+bksmh1e6QUUXUaEcy5sKakSLRn/sVOa70qIEKUo0BEPS
	10Nq+PBAo7PF6CMtYFbt6UHcBRs4EBvmw/0xBZOmyuhx81fBwDk1kE+WLEFZkI0JvGx2x3Wra3z
	n+vzwW2HWrxfBbByGSvBd1f+CSkogM9MRE0ySsZdyI/JVob8Jp6tzigAgPzA13/uEo7Sv5w6T6c
	/IpEdE5vfaNrCHzjn/SnuL+fEokG6vzWF9lwAZ8/7/bykbYbJwI1NaRSGvBM/1slAkK36s/+7u8
	knwz/OQfy4498NFsTeL4jbwSNQlJSDjXXRFuCCpJ4DkUuQs4M7MUFJ5aDh1WF6ZPDQM1mrN5pR5
	3FgwfP5OjrcziE7eMag==
X-Google-Smtp-Source: AGHT+IHbBHJJc4IUEV4Jypo+/1JbdQampEow4L8hMMEP+K4Ha/gvsWKVCfrYKD+iKgrTObgx4C+Xhg==
X-Received: by 2002:a17:90b:5810:b0:32b:90a5:ed2c with SMTP id 98e67ed59e1d1-32d43f77614mr355494a91.20.1757107906673;
        Fri, 05 Sep 2025 14:31:46 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57b227sm29772402a91.6.2025.09.05.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:31:46 -0700 (PDT)
Message-ID: <8412dce96c7f13f8d3c8fce69fa3aa19cae62b54.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] bpf: htab: extract helper for freeing
 special structs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 14:31:42 -0700
In-Reply-To: <20250905164508.1489482-4-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-4-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Extract the cleanup of known embedded structs into the dedicated helper.
> Remove duplication and introduce a single source of truth for freeing
> special embedded structs in hashtab.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

