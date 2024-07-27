Return-Path: <bpf+bounces-35795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA493DD1D
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 05:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC32CB233B1
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 03:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB05B1FC4;
	Sat, 27 Jul 2024 03:32:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F811C17;
	Sat, 27 Jul 2024 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722051170; cv=none; b=kDVVIlacy5qg25x/YLNW8xyivbkYnrNbnuc2V3eUWGxaB96GFMX+BK1EMgPn1BdrQOWSqjPpF9w4QyA0NIqUDWXgP/FtNlp+CJQ4YDz/5nc1BCUd7nYfvBmbhT5aGdb0kDEigi97Ksr37M//HeFxOw5vT5FN7UnIPqS8IREtpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722051170; c=relaxed/simple;
	bh=ASyaYK8m2d9B9ZdOQvJ6ttX1dnaks6XW0TfhicGYgXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgQ6wDpBA66qRbXAA3tpNjdIgVd/P37I6qnESIOaKsz1rNQPTM2SvIddtJktOmWGYppYSuOBPPEXqyKwLFL1YPBwDQsE4UuoY36gB56MsYJVJOIWFy0UzUXgEmgOPxK0dxfgZ9agy+xFzImaMXv/0bjlsYEqb8sEYOHKudWNwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c661e75ff6so1064821eaf.2;
        Fri, 26 Jul 2024 20:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722051167; x=1722655967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN8Peex/xJksrEl/LSj/3b5dCwyPJOzO7qLp2AEnjJ4=;
        b=QfhTBNljuHtoBCaoxGBEOjLJp/cIqwVAcKZTatmDps10A7VE2zPPEKc/YAfAViEXEP
         xZbLrwnUe4q2EX83xmLrNINfmHyuByOl7qCMzU6c3ENlSl5wIeDXCGpkONwuDRMKnRIn
         +P/mNWB/sLQweHrTYuiFeUDiZHbQtDv3/GC2Iut/c0Q1Uz1gokfeSXzgnSNmSEzRV/+M
         e6EPCSBdRonOgoyMikYIsqBpcjG2lFrhv7TUcs2MZTbhVcITHVQ3V5vBcGlZBQAUqWNX
         H3Q+LJ2CxQA/0KDdJU5jEwwnegySLcrceW8GFz/z5L5NS/zualHOrzQJd+Eu4hixcj7S
         SbAg==
X-Forwarded-Encrypted: i=1; AJvYcCVrBfk1YN0O4n/DbQHuJfHer0FHNpzJ1s0w1yThSL94JeuV3oISn6GtgnpagwFL9pMOW9Lrr9vtdi1r5P7xsS8StT8v3TJ53QvthfMv4MW1LaNwU8dkrrI0vF6t
X-Gm-Message-State: AOJu0Yw7Q62RvPb3Ps4ndnxot6A5r5zzSOBdzEpFPsfm0Rcr2u1LXhBQ
	z1UEU/D3ZDY7NBpNiZrR4E1NqdMehD8ChHKH10GLb1yqxLqBwFo=
X-Google-Smtp-Source: AGHT+IHL9OHUHytNUACaqjerzWAomXUJOVoSTICk3S9JhwIasD/OWQhHVjzL5NZ5XsEsKTuRK6RCEQ==
X-Received: by 2002:a05:6358:e4a9:b0:1ac:f08a:c701 with SMTP id e5c5f4694b2df-1ada1f23bc3mr200230455d.0.1722051167375;
        Fri, 26 Jul 2024 20:32:47 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9ec4280sm2980953a12.65.2024.07.26.20.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 20:32:46 -0700 (PDT)
Date: Fri, 26 Jul 2024 20:32:45 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Filter out _GNU_SOURCE when compiling
 test_cpp
Message-ID: <ZqRqXYljLTSKaFwz@mini-arch>
References: <20240725214029.1760809-1-sdf@fomichev.me>
 <CAEf4BzYonHCyFr7ivRDDUtsJY3MEgWRKwVZ=N0sWjpMrn1dR6A@mail.gmail.com>
 <20240726181020.19bca47d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726181020.19bca47d@kernel.org>

On 07/26, Jakub Kicinski wrote:
> On Fri, 26 Jul 2024 17:45:06 -0700 Andrii Nakryiko wrote:
> > or we could
> > 
> > #ifndef _GNU_SOURCE
> > #define _GNU_SOURCE
> > #endif
> > 
> > (though we have 61 places with that...) so as to not have to update
> > every target in Makefile.
> 
> AFAIU we have -D_GNU_SOURCE= twice _in the command line args_ :(
> One is from the Makefile which now always adds it to CFLAGS,
> the other is "built-in" in g++ for some weird reason.
> 
> FWIW I have added this patch to the netdev "hack queue" so no
> preference any more where the patch lands :)

Yeah, it can't be fixed with an ifdef because the conflict happens a bit
earlier:

$ echo "int main(int argc, char *argv[]){return 0;}" > test.cpp
$ clang++ -Wall -Werror -D_GNU_SOURCE= test.cpp
In file included from <built-in>:454:
<command line>:1:9: error: '_GNU_SOURCE' macro redefined [-Werror,-Wmacro-redefined]
    1 | #define _GNU_SOURCE
      |         ^
<built-in>:445:9: note: previous definition is here
  445 | #define _GNU_SOURCE 1
      |         ^
1 error generated.

