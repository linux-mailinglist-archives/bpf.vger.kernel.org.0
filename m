Return-Path: <bpf+bounces-32743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E6912B6A
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B471C223ED
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07F15EFD7;
	Fri, 21 Jun 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGtrbfRv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECE128812
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987521; cv=none; b=F/ssyRCzysKfZlYkwGLzibn8Hbu+VxwONcIQl+jUaN2BS6rQWWNSTEtd530+nLk5Db/DPaT65upeIc7+W1e+uoXZtkt9aJLIpN0UrTyQmDE76y4Ca1AyQOxarOUnXJEy8bQhETbo+OZqyk8L/oNB9/O1CxVZmnHRtTbKTEYX6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987521; c=relaxed/simple;
	bh=KydbRzin2tD4Lgp7b0Ze5voir2Pvtb/hIWUQTUi6owU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hk9mHejtXvPcpVsxOj9k9oe6QolBYKlUfCfP7cm0mfZ9pqwZ+iu89epHKLQ+BPbeavV8lkZT5JHPgwAItT1OOX4nq/gwwbfYmrR5j/+c1Ag/SdTVVyI9nbquKKzsRO0zRYFTahVKe9oJF9WxUXpSjFbM3gl+Ooj2bKISbXSaNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGtrbfRv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f480624d0fso17111855ad.1
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718987519; x=1719592319; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KydbRzin2tD4Lgp7b0Ze5voir2Pvtb/hIWUQTUi6owU=;
        b=XGtrbfRvdlMfOuMWHKPWB6ZtrTbuyRdjPGKNrOXgf1fOvZTOf6+30VF9ub2iOFzodm
         n9imRtBrqVzIObINq4KumIDlJMUNo2ETijf1Vj7D/j+wUAs/jsCAHwCCO2MKtgR5bm58
         HtosL3tRs8HG1Rui4gYncw1zNbjs7i6FvXUo5lrPSow0MZkxXSmBnvpI8xxNdfvPTR65
         MAMg9cnShjQ107/lQ245VdvYLA0uiM9skIZmcZ7DmesPKZm6ghe5b5hsYnShMSdigLua
         6s1KOpTyzi0+zJ4a7BoWodVbNf9BLDHtCUROAlL8Rag/auQ1gueSWKuMQlgqgdHeMuJq
         SgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718987519; x=1719592319;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KydbRzin2tD4Lgp7b0Ze5voir2Pvtb/hIWUQTUi6owU=;
        b=cvRoA0BLfR+Q/BP9QhVoW9L1RbF10YBZmyBk5h0OYlkS0eta1U0R6NyR2VmAVf4PnM
         PvLum+BZVVphygPqWdi+Lnfl2S/fuMyPmp32n0HmXuMzBaDg5nThrlhBiDFPN9wuK1nH
         P+bMcSCm2VR0OSYQvZXZmXT8ujMHimDvLfe6dw3TnmZF3bikk4wgzwtENlzJmr/FKo/R
         wK76ISg8UE9jKvUY1Y02yBf19A/aKCa94pLMMktsDZInBMWGNuak+BOV7QOjWdHlf1qR
         MNEysPBiwkJexA5gBbDgaDGnOiG7fZoOuP1goRd6u5kKFq0xon5QTTBUsvhd4kangphr
         +BFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDQCwqyj25bjED6FwI6Xzahv7twzJ8VtrYfXkfLL8zf0NI7JsfcExtAeKEKQ4lzzc5oyWDCHUdWPPtectzCrc8B+Qb
X-Gm-Message-State: AOJu0Yzgr9jdyqQMeSLZ9DcdD9n4Tr+lP72BmCt3sz43uS6PiUSZpOkX
	J56pKA5ViWvJLf40TM2UWJH7+QDTicNe6eSWfd+lkSP0wh39lelX
X-Google-Smtp-Source: AGHT+IGtzhsraF/1uBm77zCJhYLl37VoJf+qmuIJENI9CbEK/cOUDK0A0WlEDotfoplnHymaRLWG+A==
X-Received: by 2002:a17:903:230b:b0:1f9:df92:d67a with SMTP id d9443c01a7336-1f9df92da5cmr49545065ad.23.1718987519110;
        Fri, 21 Jun 2024 09:31:59 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc7edcsm15850935ad.297.2024.06.21.09.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 09:31:58 -0700 (PDT)
Message-ID: <51c1f4234746f8d5d5e61ad22fe7638215ab6310.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 0/2] Regular expression support for test
 output matching
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 21 Jun 2024 09:31:53 -0700
In-Reply-To: <874j9mp9h4.fsf@oracle.com>
References: <20240617141458.471620-1-cupertino.miranda@oracle.com>
	 <874j9mp9h4.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 17:05 +0100, Cupertino Miranda wrote:
> Hi everyone,
>=20
> Just would like to confirm if there are any pending comments or
> suggestions to which I forgot to address so far.

Hi Cupertino,

I think all comments were addressed,
just waiting for someone to merge this.

> I know this was a rocky series, my apologies for that, and thank you
> very much for your detailed reviews.

Thank you for adding this feature.

Eduard

