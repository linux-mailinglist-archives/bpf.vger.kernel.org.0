Return-Path: <bpf+bounces-21670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09575850149
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 01:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC90A1F2A533
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 00:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484661FD7;
	Sat, 10 Feb 2024 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/NAL2NX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B2185E;
	Sat, 10 Feb 2024 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526063; cv=none; b=VxgaPaVJpR62rkjZeCKb37MBDPG3AUOvgc+yfsT6jVRQWCj0PkbF145MImJSMdSvwx++gqCIKGMB4zWl3bf2upvDVXLxFAkDHV3ObI5PQK762nbZ3BzegW8YdZq9+i6gNqoHlxgeiCaL32PA7ZRjw6xbd1ADJlAXNtMo52PP94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526063; c=relaxed/simple;
	bh=3GkM8TGREygwBB1OKJjChwJhWO6bfKjIxm42ycxuJ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOK51zeCaYHN/h6AFe1UuCni190AWgizvcL6pFexKTKpCqIDfvcaleoI8mTCQC1o+8yDXNIWSBCkpAfpY3+LP1pFmu9m+TBf81L97DbOtfSLI0P97oKUOh5D6tAR1h98u2CbyOzUFNyaaKhIC8zg1Z0J0QGou1ruJfaMk3Folrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/NAL2NX; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-783dc658bd9so72364685a.1;
        Fri, 09 Feb 2024 16:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707526061; x=1708130861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3GkM8TGREygwBB1OKJjChwJhWO6bfKjIxm42ycxuJ+Q=;
        b=L/NAL2NXQH20vzpZkUHK6lVI7hUwSj8UqM2f652dcFNjgy9cHHAyFrF89IewtI5DLE
         48LzeX3esmvDrTkto9Jy1bO9iAcyTi7lFg4d8r1oZ97VpZyPJG2hCCtuIgrb02JIWuph
         fgaehnTkm3cRWhREzj+0JdWLHcoXjwfsXkaC3SyFDmWTcCgoaEFpDkoBmD8o3YBxiDlF
         FO51hVpiXzPx24WubRV5C6tfFgDMzayD7bzpWTj4TV+yzPGbOT8dwO69twecrIIkJTK9
         LgJzMLN2sbHC646NeI8SmoXuPfejjwzM14rgoid60MW3U47YjOYs3hFLgo7R1Wa+UHzM
         6Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707526061; x=1708130861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GkM8TGREygwBB1OKJjChwJhWO6bfKjIxm42ycxuJ+Q=;
        b=tG4grdWoLFau62jIAjpBfaA3WJis7KE653PbZWAgYOu8LQuQSOOiLypoAN8XqPD29E
         N6pBWTY+KzwPARix+m4Y+EcxeTlWjBmUpDeD8kXv5KLRA1T8fTTFseMRLhOlhmm3kW+/
         Ii5IS6ZwnB3q5GTYFj9J3bfmXkU+rciVTH1h5Wvhci4dfvaMUuJrGiYigzIT11XHKp7N
         HY1xVk7xDTh9/imdrIH7zFtJ09kr23VVW7n1jA1L8ckwtbYZ+IxDzLa7lbhXioUoWgqC
         KjW1UjXatFFat8NYyLa9oExWh73MfRxCboVB+5G8MG2mTnSS6nXQwjpe+5v7Lwrtdb3b
         A0nA==
X-Gm-Message-State: AOJu0YzNoUM7+CXa2Dp4du88lqrV1XhSP5c4DkqTwfOU2vgZA1e7IZDe
	w7SqDdIcFZB0mD9F/TKpfGsGf6ZH0JNXJDapwL9q5Q2/W3bimU8N
X-Google-Smtp-Source: AGHT+IEiS2PSanma8pRBIGOiyOV6412n5dDFOflinxf+2y5W7ZlHiwSDwM6Zt5PtTSKWQgA5kQa1cQ==
X-Received: by 2002:a05:620a:4e:b0:783:f7b0:375d with SMTP id t14-20020a05620a004e00b00783f7b0375dmr957691qkt.70.1707526061337;
        Fri, 09 Feb 2024 16:47:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7gPGXLyOKCP8EfUdS24xzv7mM/YMcqNnGU21HT+mfX0SoqikCwgJxtRrHq7Xx5cWwWBf9rXicClDOWNUvLpu8X8Azc07uNkFvUSKJ
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id qb1-20020a05620a650100b007858a9032c8sm218107qkn.24.2024.02.09.16.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:47:41 -0800 (PST)
Date: Fri, 9 Feb 2024 14:47:38 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next] net: remove check in
 __cgroup_bpf_run_filter_skb
Message-ID: <e2po4x54ouafemogi3uaft2i25qieamr7oizisz5gutcfyzt4i@zyrbjb4cddfs>
References: <5ac3e6uwvhdujq6tywb6b5bh5flqln6d7kedmcbvhyp55jp4yo@65pnej6e2ub6>
 <Zca80Uetl26BsICU@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zca80Uetl26BsICU@google.com>

On Fri, Feb 09, 2024 at 04:01:21PM -0800, Stanislav Fomichev wrote:
> The bot still can't git-am it. And I can't either. Did you somehow
> manually mangle that part above? The original line has less trailing spaces
> than what your diff source has, look at:
I literally saw the bot issue and the spaces just before you sent this.
> Can you drop this part? Let the idents stay broken :-)
Just did. Didn't manually edit the patch so I don't exactly know how
that happened, but thanks for pointing it out.

