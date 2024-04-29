Return-Path: <bpf+bounces-28148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153268B62F9
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46ECA1C21BF3
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3D213F439;
	Mon, 29 Apr 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm4OSSI3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6212B14F;
	Mon, 29 Apr 2024 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420664; cv=none; b=sbosfEc0G0WZgQ2yVTAHf4Q9NLVNtYogPn1azpPtUc/GohmQnKqkOO9pRtX5H4prCBqIxJT+AsFx5ydSz4aLjjvuUUJfLNzQnj8Cb8fBTYSHR2raVc9FJv5JxqluwNvgGVhVdReaUYl8ih40sxSC5Mj0MiinFLD4wo3n2vFjZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420664; c=relaxed/simple;
	bh=jxQQzLxtQWppXiluZ4oXuKycDQUP4fDPnIUHJxz3R68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRj/PbP34WWrMIojRTZjaFhhs610DJY3abVNXTYMzts63L5byBGDyMjQpg2CaKjkZUlP0w+ZAOF/uRCRakpZN+Rprs7Iub8HGT+g6ufyuUYPHP1H+TlMUJNmgz6b6ZifweVSBp88kbbflMY6y/3Te3iii0MdL2IvF67uSjYFUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm4OSSI3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so4179765b3a.3;
        Mon, 29 Apr 2024 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714420662; x=1715025462; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jxQQzLxtQWppXiluZ4oXuKycDQUP4fDPnIUHJxz3R68=;
        b=dm4OSSI3TXFN7au+ezhc8Q4hg5ComNeAYDFZd38/Xrw5WIdqt5+SwBIF2iuUF9aDkw
         ZSPOBh1kIlGgB/Atx4ThiECiiUfCFSetMgnvc3QIt6xPkh2Wh9YwN3e2odL1W6c/t15e
         U9F5CkHtnuDZ/m4bdpPuTJ7LZ+QV+HkAQ+4mSwthCnMUbYJPx1JREKTgFV+ijhXREGkG
         7bqfSwhM0bWQVedZ1r2BPlS0sm4NrqDIejAuMU//AbF7NqXVkKXoc70Tn64z3qJKCaiL
         lyPcMzcz1hkDsoIt9T3OV0GHZfcbXahceSs5Hl1sws5woOw/FL4bH9etgWWg4AhwgTlp
         nSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420662; x=1715025462;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxQQzLxtQWppXiluZ4oXuKycDQUP4fDPnIUHJxz3R68=;
        b=P4bj3vRynJtb+DMhj5K2VoivUSZVXe90w9io0fEHPMvbGVuXPQfhph4zX7Rilo1J5a
         B3XtIrW6hZ/+77SLVPaBPEXVFUIYL4TogZqVMRiN/d/xOJcMXqGLlM5aT/ka0y1LKPvZ
         SwJkS5MhROO1xQuFXiQWlTf8e/ypqA2zDUR8MWS+QI9xm2dA7a5EHGngmVnDfocYtwx6
         uS98v6lR9SvuOOI/LNuO5VVr4FyVKb9KJQttMnW0ZANbz5s7bL7BeTUwFvuOLiUHunxW
         c11nKy2rWxbJu+8wiVJuHXuF6fwTL7nX107sLW2S/WGn1/Q0zKp5rmrH38jVmckAQO5v
         Aj2g==
X-Forwarded-Encrypted: i=1; AJvYcCVEHuF3STY3M675FiCbV2YtQEtusqGp30KO4c0LDS4AUa2OsstE1xIJKWuw0oNK5VimC14GTjhGJ4T3Ydqx3xR2d7na1f/1I3aGzs06bN1gRMaJVuzEThtCboXv
X-Gm-Message-State: AOJu0YxZnfgpA+YdX+cdAeos6EwvWkXEJF9TDsSWZjOVIf6ukXBF2zRg
	ffP/+0+DvOqv1shS7trtt6+AfnwVbGgkZhHpgNJfup9IexR3icjy
X-Google-Smtp-Source: AGHT+IEpFtXh9owW8iOqvqX/rZsYtvVrG+3oPiRKhH8jK4tTpxMaFQvdnU4puhPcHIbmpCKXISoF5w==
X-Received: by 2002:a05:6a00:1791:b0:6ea:914e:a108 with SMTP id s17-20020a056a00179100b006ea914ea108mr13739750pfg.12.1714420662125;
        Mon, 29 Apr 2024 12:57:42 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:a18e:a67:fdb6:1a18? ([2604:3d08:9880:5900:a18e:a67:fdb6:1a18])
        by smtp.gmail.com with ESMTPSA id fv3-20020a056a00618300b006eb3c3db4afsm19644085pfb.186.2024.04.29.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:57:40 -0700 (PDT)
Message-ID: <dd4c47a93ac3459d912eb3c4c77e08d8c431d164.camel@gmail.com>
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Extend sockopt tests to use
 BPF_LINK_CREATE
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  haoluo@google.com,
 jolsa@kernel.org
Date: Mon, 29 Apr 2024 12:57:39 -0700
In-Reply-To: <20240426231621.2716876-3-sdf@google.com>
References: <20240426231621.2716876-1-sdf@google.com>
	 <20240426231621.2716876-3-sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 16:16 -0700, Stanislav Fomichev wrote:
> Run all existing test cases with the attachment created via
> BPF_LINK_CREATE. Next commit will add extra test cases to verify
> link_create attach_type enforcement.
>=20
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

