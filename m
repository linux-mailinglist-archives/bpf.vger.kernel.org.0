Return-Path: <bpf+bounces-30631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5098CF86F
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 06:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5C21C212E1
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 04:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3979F6;
	Mon, 27 May 2024 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NlRBQ0NU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A22DF59
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784616; cv=none; b=rKcNbYBAtn7yhcoDjwy/LtT8NITK6BumNUjYEfaXHK3etMWxTpUQ15Vq6BrW3ibLURqTeC6FfXo4tDdyPpPgrgUhMOwCsZvb7Gho/dP8pONJjWRQ4dFUoY1zY5qjs5y2izUO16lqb3qO5nd0IDRz6+GQ8g8EPK9ZZNXUDf7IlUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784616; c=relaxed/simple;
	bh=xpxqGaiKfuTGZlx5C3yG3JESz1CQVQF76M7uSgTs2tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1ByWVpaF+i8xh8ZWt3mBOm+VQ969wVfZNodWMci/zm9SxH58OxJFPrSFAcTcPqic+nY/cdO8fVn7kNDrDhQlZEEklwu1NrKgy6blAAUprhO1VSYxF5QltfJyoQzNCMYZe9nIeHLgWxDAlL7YdQmgE1Y91GpSKyyEYLVqYp8l+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NlRBQ0NU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e95abc7259so28095151fa.3
        for <bpf@vger.kernel.org>; Sun, 26 May 2024 21:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716784610; x=1717389410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llk8LuZ9hrKrtnYl1E0Es8w0gMe+Gg2swe3Lwr5IB98=;
        b=NlRBQ0NUk/nNn4qBVmOcW+r3xk2fs86QTv7jiStAR1LGpMI5Zm2HgcRhquTbv/c1xB
         m/GhLmXZ6AVydeRI3HVOCCJ+qqha8h2MbWQeX7/ZKPqF66/aSjPRDT0tTpdt1LIulljk
         zIntFEt0S5yJ7PtSfjdNYrkYeVghSGqo5yNnz0z0NYv1H4OdYaVlQE+j/PlUrnVCMrEx
         XfiPO2/ovpv7e5P6xgugelxmKZco66C00EPjTbKO6EPrzfHyvjIsOfUaK302Fp/yeAR1
         2Tt33wJ4nBPwL0VKHa1KyOKHCvJZFEYfHT6adBAPuVannew70MkLL7XfOUqkdz9lTFYs
         4SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716784610; x=1717389410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llk8LuZ9hrKrtnYl1E0Es8w0gMe+Gg2swe3Lwr5IB98=;
        b=BQ1TkXiSM71tNmB9kJR7tI3oGstoz5151oxuCC0yz0z2MUX1KmBPaqokea8/jV7LAD
         /vfIGvig7nxz1zFmLCkE62JNCPU5dRc1tth870ZUMmBTEWGp7PQ/DBSI9MOJYm7qtEEL
         YQPnaqTiWjuIGwr/BQdLDJk9FrFq0QqaRZCo5FU6HMO8zhbi9VNF8d0vLnlSKNJbkiLq
         MIGYtXd376nNXCGFzu+evpIiI3yomI38oBNdqA4wTYu/qSFVtvKsssdEqkKEcLXwjdMF
         GosknPU+IhI34iQMElDN15xCmI3MIYtpTxen5YqEVZwgUF089faFB7ei6LEUrYSMTj6z
         BVtg==
X-Gm-Message-State: AOJu0YzjzA4XkTTyVQROvVWXdjcC6av5yOj/V3W/AAoKHXLCW1jSxAhM
	muKfG478h/Vc2kahqtha2JYNX+1k/ZRjYO14fKdXta/ZAMtKM/iQ5mCWAkWQp2w=
X-Google-Smtp-Source: AGHT+IHGrIZy3/KYewvki8KYVClJkZdPoZ0Zqe/hgfLYGvefGRlmAI1yAFh9lCU8w+WyS2OqzBx3uQ==
X-Received: by 2002:a2e:a289:0:b0:2e4:7996:f9f0 with SMTP id 38308e7fff4ca-2e95b0c0f7dmr46267161fa.17.1716784609992;
        Sun, 26 May 2024 21:36:49 -0700 (PDT)
Received: from u94a (106-64-120-248.adsl.fetnet.net. [106.64.120.248])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e9062a7ea1sm151112339f.47.2024.05.26.21.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 21:36:49 -0700 (PDT)
Date: Mon, 27 May 2024 12:36:43 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>, 
	Dave Thaler <dthaler1968@googlemail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Move sentence about returning
 R0 to abi.rst
Message-ID: <ktzwr2mxzqcjg4wvxwenpwh5yq5brvbd2u3zhbopx67nes76k7@durfvo77a2ty>
References: <20240517153445.3914-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517153445.3914-1-dthaler1968@gmail.com>

On Fri, May 17, 2024 at 08:34:45AM GMT, Dave Thaler wrote:
> As discussed at LSF/MM/BPF, the sentence about using R0 for returning
> values from calls is part of the calling convention and belongs in
> abi.rst.  Any further additions or clarifications to this text are left
> for future patches on abi.rst.  The current patch is simply to unblock
> progression of instruction-set.rst to a standard.
> 
> In contrast, the restriction of register numbers to the range 0-10
> is untouched, left in the instruction-set.rst definition of the
> src_reg and dst_reg fields.
> 
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

