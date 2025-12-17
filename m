Return-Path: <bpf+bounces-76836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D946CC6A02
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8FA8301AD16
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20947336ECF;
	Wed, 17 Dec 2025 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMfs8rch"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E5328617
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765960701; cv=none; b=V6C9DDUzGyRUxQwdX/1PhdeQvQAqZ2W+1Z3Z2oxbdtaYtuagzskufI2TnEb5af1oAbUWiBZX/Uohep2NqfUJFaPkrLADdinvvmjgtZ1pOVQyzr+HRSmdxSu1QKGF3tIpPZJZu/EYU4oPvGwcoIf4d35CSBhFjk97yU2kttzfIUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765960701; c=relaxed/simple;
	bh=QAOJ8ABIbdU0o0Pqb6FK6yvMYxorI5iARuiJJ/qxmlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxEAY7RZv+HkgL+WmnEWZp6y522qRo2ibBjSkjDobnNw6yNOXgPM8w6W8aontm8kThkQ38ZQll/6DJEpaPNkovVhmqU//3U+sA7dcTsYXe9WPJZG+8y84jnNQz3n072ei/eEa9rhCKKy9O5SUwBJXl5T4hAXJdR0efSgv4aEeCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMfs8rch; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79e7112398so1077455566b.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 00:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765960698; x=1766565498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YbJ2XFwBfWAbzLUlZ/npKwyyDD/E4jChifbWoG3alE=;
        b=BMfs8rch/6zVHoJsvUXj77alQG/wPmLgV0ixPXj80c3t5qCDQdDV/Tb1qEzgeVFRU6
         oMzlEDFx4IJUm/ejue50UbjC2MfhfjcfbUgXVNzmUFIM8BFqQL/oWCYOuSzWK9C+BHw0
         nxBqDYoRmZG9uRHabscAKSQSuRqA207S5+BuiIi2w08Qoa0YfG+QfNf8ys1I5OEKydU+
         G5fFkuaZfPqYynZ7mjpsB/ZzQnSNkxr6sw6/6IaBWs52XD6BPkBB4pIbLqTKIwf9ztn7
         R/6H+xd07iuX611fTRpdmE4ePT1/thOywQhiPLh84qOBYSXjOVv+CAVb4BhicmGzMuab
         aX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765960698; x=1766565498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YbJ2XFwBfWAbzLUlZ/npKwyyDD/E4jChifbWoG3alE=;
        b=nmyFNCnS7ZX/4rp/HoYQbzwcV0ftuO6dfOoAylMbn1WQd5L6oeKPSSwO6qmVms/uGa
         TY2CxHSFvhdXeTD1czziBX74BeI2+oNhn2HOf4cyY/5bM6uuAevg1PB/1u8DO/9RBnrg
         otoDleCNJV+6TJsAe6McVoLfFpq1/r59IAhRhADd2xvRtaw/6ojY+8wUVD9hzEBGOyqs
         VgtFHW9Shhuz+EDOqfuPSmeju+rhhNjVFUIrpXjdvr93OOwJ+W/ER9iW21UgOetoZlFW
         6XMRcRCizXSOX48exQhiaJBtSAEmBRUH+YWiKf5an4Ej97lXO/AG0KnM/9Io73I1phme
         nYLw==
X-Forwarded-Encrypted: i=1; AJvYcCUP7o/O3P0yyNuBdkNd/SEceBWL84L8FZr4Wo9c9iZj82XJGvVXl1efAYbtoC0XGawq2ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5AvKtXoPLbZcXPa4I9zVp3p3HGYh5cLKhCjEXx45acFtyiPtq
	xjlIAAqqkBZTs2H5+g8cApeFxRSAJqxmOlewugR6d3iOXBvMbMNUM//ldsPZ3YZ0W81l7RJ8Q2Z
	c4vmifsR5soksGWg8YNciq8ZeYwpYT60=
X-Gm-Gg: AY/fxX7Y1ck5kW74bbykJQtbZbVplNiSlh7tmOT7Fj3deT/dypZAVqlczsxxJpqLKlh
	HmaWfTC8as9NFrMezv0ao+6sW29NoraZaCARrzBeAJyrriL/tWfi2TqPSTPowm8G7JpNpDb3wgO
	lnTZCK4KQ0vhFG6+xRaJn8wSQj2WN8JzMUcx07VVuhhxMgmgSbMGpywIwgLwY9xgN5cV37WnOll
	HYBo60bbVhwbZyNMVaGR4OMTCGhXPde2PBUhOnjqKH73yc0R6a22Zl4X8mn2Z1PdQ9RaDwa
X-Google-Smtp-Source: AGHT+IEmcBYe47tkj3vEVyWaFAuOlkPZRhYLN/Yxc+T5Z2SAEOtXb6VCrmLToOQUO9hYJ/E00ribc9if8ykIHus21RA=
X-Received: by 2002:a17:907:6e9f:b0:b73:79e9:7d3b with SMTP id
 a640c23a62f3a-b7d236637d3mr1793674666b.25.1765960697975; Wed, 17 Dec 2025
 00:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-11-dolinux.peng@gmail.com> <cb281366a96c530d6ff9b554a5c70b168d33423f.camel@gmail.com>
In-Reply-To: <cb281366a96c530d6ff9b554a5c70b168d33423f.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 17 Dec 2025 16:38:05 +0800
X-Gm-Features: AQt7F2qpJdwOLtaIBkNL0KpPzwvNeXwZohLfJzzByqVLftVyNm2jYBNgMsD2rnc
Message-ID: <CAErzpmvNF3HZHfMYzmwVL77q0_V9qT58iQqRy=UnX905N54_XA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 10/10] libbpf: Optimize the performance of determine_ptr_size
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 3:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Leverage the performance improvement of btf__find_by_name_kind() when
> > BTF is sorted. For sorted BTF, the function uses binary search with
> > O(log n) complexity instead of linear search, providing significant
> > performance benefits, especially for large BTF like vmlinux.
>
> Is this a big win?

Here is a comparison:

  w/:     1us
w/o: 351us

> I don't like having two code paths for something which is done once
> per BTF load. If it is a big win, maybe just stick with the first loop
> (the one that uses btf__find_by_name_kind())? Wdyt?

Yes, I agree and will only keep the first loop in the next version.

>
> [...]

