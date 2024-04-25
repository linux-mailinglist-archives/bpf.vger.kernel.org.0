Return-Path: <bpf+bounces-27848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C68B28AB
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 21:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4A81F23D17
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41D1509A0;
	Thu, 25 Apr 2024 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOd+L59p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C814F118
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071754; cv=none; b=V973alAo3HchmDDhXcJfnQGpvYCfEqnI6ZCHEKwOs1k3uUmbMI5d/EFtJn9g9fRjExAawnyV80jXZ3X0lzfXuWuklxuGQKWuRGeMZRSbC0Y0FEeqhnQztid+72du62aXcRI/ztzKDTkA3fUZEt+feAUO5S1G7cwG7nIbmE9bBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071754; c=relaxed/simple;
	bh=YnKCAj9chSldBxQzJTpqOuAwNmj4iTwKlar+S3CjsK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGrvV81/Dq0IbiVTVzzO8Me827psYqwGas0Eiouw2XyRP1vhFmvuXEn1gYFvcXkwecGCwryCWIq7n/oUTqaowpKUEDWhwF4rhIk3j4sriskYupTOigngXhzxKsrS9DGSeQL6ddLMBYi5WLEeV3mYQgJaKzUmTnPBe3FXUlsiTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOd+L59p; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36c30a81507so3163995ab.1
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714071752; x=1714676552; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YnKCAj9chSldBxQzJTpqOuAwNmj4iTwKlar+S3CjsK4=;
        b=GOd+L59pDnAHi7U8A4pPwSPuSpXLmu0SiolJmUgMw80LeOufZPrrzLFFKENwDwkgEl
         aEma9FsRTES0HoBLI6fL9uU71CnsxLA7YSt1lYmDjcd7399ISYn9QXkkdNBeDqoxNJcu
         wrXL522wfNyRFoV5BnPi/LIqXSdQdeCQ9r1rRjPN/5wxvyFdnzNsvWXaSXo/tfJmd3vS
         UBuG8qVgmPmmLlxhUlyrm7zcHfs5ggP9qgHzzs2PFDE97/zkgudZhpgvPFtoKzu+RIe2
         Ur/z+DDJnrByW6RRrNuK4e6t7no37aKKweH/cgD1AiOlvVg2aOhPFZ5Emj9JNEfSXegB
         8i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071752; x=1714676552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YnKCAj9chSldBxQzJTpqOuAwNmj4iTwKlar+S3CjsK4=;
        b=J+1Gk7y49AP0tS5TK02zAgUwL3wROPLIm7slvgUGDkiafcFbuG/QxsqKnD4bp/7xjL
         0xnAavlxVgzuSUYwUBtCxxhNMuJB16ur0p/BCvAdROa0KlDVk5yVDO6WYoOiz7NS3dY+
         fgyWayZ7R1lEPgN5a0ITMn+sO4Uh8RscStbTaFjcL0/rC9QyR5gy8Vb4WWRT9QcodNw2
         sasJfoVtqbsxeuH3k0Y3r5Zo1o1gyjZqTFn9HQhr5YNp7Lkmq4cCDohAbCdWxJxr6brz
         IILhYnD/bNb12rHXYLUD3ytmMJhzO6mF/oWVBgxXCbx6J5Q4JSSNMGdvlGxhjQzATBb9
         CUFw==
X-Forwarded-Encrypted: i=1; AJvYcCXXX+XHKk3UZdUoDw1/Pp87/BEWNda1S4Yv1xh1HolRghyUbvWe6ynYbjJ9OUNTbr85E4OcJNp50FPIm26Q/BQkmHLl
X-Gm-Message-State: AOJu0Yz5bB/DeW9/BypBwl0oNHGX3wiSttaK2B6Sy1IVN/wIdfQawVdN
	R14Z/CrtUfS+DTZVdj+zpRyRo7+jMfRGW+zAjsjZIE3snkB00sVpFWElrBGR
X-Google-Smtp-Source: AGHT+IFI5YDxZKk2qc8tiyILDUXkPpLAYCCtVFZw78GdbmKII1nIM+Wc4Sqr5etRcOuHWI0r3fZqZw==
X-Received: by 2002:a05:6e02:1fe9:b0:36b:fa57:bddb with SMTP id dt9-20020a056e021fe900b0036bfa57bddbmr795085ilb.26.1714071752443;
        Thu, 25 Apr 2024 12:02:32 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:b5d8:5a56:aaf7:f817? ([2604:3d08:9880:5900:b5d8:5a56:aaf7:f817])
        by smtp.gmail.com with ESMTPSA id a186-20020a6366c3000000b005e2b0671987sm13245951pgc.51.2024.04.25.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:02:32 -0700 (PDT)
Message-ID: <906a4a4378f9d9a5fd3cd823c8461bf2fa50e7e7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: MUL range computation
 tests.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>
Date: Thu, 25 Apr 2024 12:02:31 -0700
In-Reply-To: <20240424224053.471771-7-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
	 <20240424224053.471771-7-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 23:40 +0100, Cupertino Miranda wrote:
> Added a test for bound computation in MUL when non constant
> values are used and both registers have bounded ranges.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

