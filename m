Return-Path: <bpf+bounces-38581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED72D966821
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983F91F243CB
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01021BB6A4;
	Fri, 30 Aug 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q45FCVxY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509F16C68F
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039414; cv=none; b=A8YWFng2yQf6Meto0Wh/bDCchhSZU+p6tlB2lK8YpX/ji36ZqDmOAFpxjP6bNBXRSZY/mETXaNN3MiVM4tZdLpJo7+mVYgtzzzphuSM7InWj40g3fgXufvlWzDDkFZW8nvtVdy7neJMJORVDHAPr5Y3p0nXYrgnoaqmHXz6V2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039414; c=relaxed/simple;
	bh=gkabglCfmxFQ1Ufxyk12Ux507KQQhJ6FwiObhlwD3fc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UoVEP3/OOeS3uNJwmtJUM+4imAlXzmMjFbStAXSAJWJfw/ykBsUmKurMeTiMs1tJSS0qOleGJqLtyD+XxFiYTKIlbK4qW9wSSA1Wq1jYJd1tVQd8uAz3dAOqCHdC7oBIcQA8w4x9KVEbqXY0o3bFyHempzVMJDH//dZ6M8aKgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q45FCVxY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201fae21398so15281585ad.1
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725039412; x=1725644212; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gkabglCfmxFQ1Ufxyk12Ux507KQQhJ6FwiObhlwD3fc=;
        b=Q45FCVxYLatfZm/XaznRCAVzAWHr1VQMXviTXuww7jqhbSIGHCtezDcq2nMYtBEXVV
         UYa2ABJLrTcLw/cnvjIitpPJvrAN2YiH1OM5IA9i1UsBoAyxZ2o4FTxJ50ihLg9piG6P
         g9QaWHgfNe5KhTSn+JtV/ycKifWdBHklwPEVjvAnvX/vV73KvbZjDq9uVSolNDAC6MS6
         cYlDOU03v6RTo5qldwjxlcPI8aBryE5aXgx0FEbkipRvsBD5c0Z93jc+xpAf655eVwkw
         MHTESVdxHvccik8q8RLqhDlX0lhtj93CbM3T7SLljjmuy4GHr4lk6hfwp2kjzhFQyKbm
         7ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039412; x=1725644212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkabglCfmxFQ1Ufxyk12Ux507KQQhJ6FwiObhlwD3fc=;
        b=PlOi87QKgPkGJH6vaKfNPwixBn7s9/cCADl+v61faEEW75yoRGOj/9yYS6a78cg2WC
         deea804vuk4RZLdoiUMbFnKssp5epj0hR6jFsC/fEX27M4Jp9AyDHRYDtfaCq/8I1Ul1
         2kkkqHpzc1BwKpKRbtvcHPpskxxN57Ug/YSannJ5jSDGofjgAlA9BGWywH26ILkr3trg
         FuOMKgxJsImZG6ukfXFilLx5yRzIjpX6yXKw04Ui+A4C6zSjGfv3f7RANWAT7voedk6g
         3FnLBH3jogYv0RuZ+RNr6+AM46uz9MfMwWub4qtmoJqNyn9QUhCU+/aiDQz2XkB5Gl+0
         8tHQ==
X-Gm-Message-State: AOJu0YwfixcO7ooM3swqjZnC7VH6LyXzKAcyW1zlwK/Nh3DbQeGA7+L5
	PKqUu+7ae2R25B8mTRcLbgY8/NBsiZiMEKQSmGb5SwLPkuaKFtnnxgKt6A==
X-Google-Smtp-Source: AGHT+IEjFxog6CyxpnU6CgrBn9sh0MhAYFrhlkq+1FdVGze69UqF/H9MNenMdECCDuDrseXLSNVJAA==
X-Received: by 2002:a17:902:ebc5:b0:202:3617:d53d with SMTP id d9443c01a7336-20544500724mr2164185ad.25.1725039412001;
        Fri, 30 Aug 2024 10:36:52 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2052b34ca27sm12987675ad.84.2024.08.30.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:36:51 -0700 (PDT)
Message-ID: <8409d6f7118f6b75f2b9b011068d1dd51eb3ae4e.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: check if distilled base
 inherits source endianness
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, tony.ambardar@gmail.com, 
	alan.maguire@oracle.com
Date: Fri, 30 Aug 2024 10:36:46 -0700
In-Reply-To: <20240830173406.1581007-1-eddyz87@gmail.com>
References: <20240830173406.1581007-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 10:34 -0700, Eduard Zingerman wrote:
> Create a BTF with endianness different from host, make a distilled
> base/split BTF pair from it, dump as raw bytes, import again and
> verify that endianness is preserved.
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Note: this would fail on CI unless [1] is applied.

[1] https://lore.kernel.org/bpf/20240830095150.278881-1-tony.ambardar@gmail=
.com/


