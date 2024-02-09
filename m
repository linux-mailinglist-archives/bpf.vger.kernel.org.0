Return-Path: <bpf+bounces-21652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0312E84FDC0
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 21:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F13B21612
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085536AA1;
	Fri,  9 Feb 2024 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv/d6sw1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE85567A;
	Fri,  9 Feb 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510981; cv=none; b=iJzhKeklek8QBbZy7+g1ouIR54yII/GPwIFLe6FRkY/2LK8AUxvAOZ582J1o8Q2KbvlJ5OPH2H+IUs9mfQv78FpZMb6rse2V3YyAdlCFeBIjIg7rtqYVq53hKqt5JZaSw04zFR5ilsWJr37ZW+eGhZjHxjsMj2HkbpfCAaAUJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510981; c=relaxed/simple;
	bh=TTxo07X6sjchqjn/ZO+xDj0utJMepBk4YhePX1jznug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3a3cbzwtX1xbASPRmLgl//7Ug2KWIDBfhRLzo6EC7oyTAkMzs1mrJr5p07AwXmaoB4YAwK201zz0AhV5+rALGiE0rdv0iuMKNbMtBRTgDHbRZiXA5FCkz0Zh+m5lraAKj/MZMgflnUvDEZ7hgO98RCt1eO8l570g4Fq9/MtpSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv/d6sw1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a8a398cb2so7688851cf.1;
        Fri, 09 Feb 2024 12:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707510979; x=1708115779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NfH4Jtpravkp5AYub7HNZjiUrbB+WZLSTKhuDr6IUEM=;
        b=cv/d6sw1X+XT6juZsHd5CiJu+hA4u5PQDdiTiPloPUwLunJqvd2JX/wDsG5I/w2mjK
         8O11lxoixGhnv1zvTnyViXd0BATRv3sfgrGmKox1PAihy+OIv1u3c/vRdX8weBK6AArh
         EkO0eOdD3fir6yvOrJGKQYyj9TMnVDAsAuFPmdNaeImKkCG2ssdiyDcg0iLVmfGUioRu
         PfsYvIzt5xGM/RbY+56loBXhvVJQDMKzyQJhG7vF6WNZ43B5eYWgTpx+R2cht9wb0d87
         wcYvLw8UDLrQ4a5MYkNvDTCf7em+R4vBB7RKMgI3XXIILZTjW1cC26z8y5ForgqQ703+
         J4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510979; x=1708115779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfH4Jtpravkp5AYub7HNZjiUrbB+WZLSTKhuDr6IUEM=;
        b=oWjKpNHf9BWo39Ll9bEDZquMS0qgcJFzLB6nHDNUNWQq+84MPLY40nWdQwBPhJAZnx
         ywIV0XYTq//kGbzhIseOfBV6aR6lYUM4UyBRCHcU7CoW1ht4IvYJbcPulXqrFxZW72ig
         Df2cl/aXUjGANToxzqp3C+Elm5quLBgMhWYl5wAJzObVL4DffdiFP4M+dp6DdhMfw1Xy
         dfyHNc5ueI70KmSMOfPkXbyNGauVHsPAKr5Hml8agx9IpJX8c5bvCvu10mvIZVLaTCxh
         o2CoqN2+tj4nNi5c5qpnbQt7vVJ0w2BlJQompqxlidJD2reWs8OgmGd7RuFFJiRjEZp6
         62eg==
X-Forwarded-Encrypted: i=1; AJvYcCVsSMXju7TaZfJh66uUlQypTriSNPbQ2qfH2cK9X5DhMwVAAXocgq/1Q+9oDjCkqqD4bS/NU5fpet1ygLA4IwabJtlN4RwF+woi2SRI
X-Gm-Message-State: AOJu0YwYNbg3VsuUMO2ejN6X09hV5lJALWj0nt61MZWT6pPo4DecHtIg
	EDUtOpyDozlheANY8p7DhW6+dcaZ9yiq0ZjklzZfqssRyEOXj7R8hU44kcrQ
X-Google-Smtp-Source: AGHT+IFJCV+LX+O60sVrcOE89eBffljDoowypfR69DU5PSC/+VDdkF2KOxSBCWVk0jElAeNj08marA==
X-Received: by 2002:ac8:588a:0:b0:42a:db63:2bae with SMTP id t10-20020ac8588a000000b0042adb632baemr429126qta.7.1707510978865;
        Fri, 09 Feb 2024 12:36:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXQUt0V6QsGGEmNEgLxJbi6bTb97p680u/j+cL8w62icyhXCfphB4GZSlLtooGX0Gaa1i3/Fj9s+R7CLOxTMnvGGXwCNnqN60+QSr2
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id y14-20020a05622a120e00b0042c22902ca2sm985008qtx.81.2024.02.09.12.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 12:36:18 -0800 (PST)
Date: Fri, 9 Feb 2024 10:36:16 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: remove check before __cgroup_bpf_run_filter_skb
Message-ID: <cjpbt7mytlmzq7gggvzkyvuglta2nknx3p5ab65y5feb5duyl4@ckej3n5szda3>
References: <ngc7klapduckb67tsymb3blu2wlmdsjo4pa4gbaivgxezbwzxp@v7akqu7gbwl4>
 <ZcV1GgitdBUIcKJT@google.com>
 <3htegzrugq4xwlizizsaku6g2pzwhndcnxxxmji4fvblisiuro@icvcsa3mky3w>
 <ZcZ2ObDxRwZ-hKLb@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcZ2ObDxRwZ-hKLb@google.com>

On Fri, Feb 09, 2024 at 11:00:09AM -0800, Stanislav Fomichev wrote:
> Maybe we should instead remove "(!sk || !sk_fullsock(sk))" check from
> __cgroup_bpf_run_filter_skb? BPF_CGROUP_RUN_PROG_INET_EGRESS makes
> care of all those corner conditions. We just need to add those checks to
> BPF_CGROUP_RUN_PROG_INET_INGRESS.
> 
> Let me also CC Kui-Feng, he was touching this part recently in commit
> 223f5f79f2ce ("bpf, net: Check skb ownership against full socket.").

Completely agree with this -- it would be best from a performance
standpoint. I will send out a v2 of this patch in a few hours.

