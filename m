Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704E52F1EFE
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 20:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390794AbhAKTUa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 14:20:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730195AbhAKTUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB2C322CAD;
        Mon, 11 Jan 2021 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610392790;
        bh=olVEMc+XOZR+8aSiw15OyVXxdYpT3dUpKHVf7JAjRMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qwQFaFGMx2YxZDf+JPAVyCdCtmbg2P/fKu9aPxsYlKqHv2fnO3M1uMyZzeuV/1u+4
         IQy8ulbh2T1+F6BTemGOao0flcLsTOTTM+vkx9P+/N0PsgCwJ73ng8VWfNI0hecWMd
         U/oMrsZB5k4x6zJDNvhUpPaKbhbnzYTwgISxCYZ7SRguZhuVEBSDPmZV13VWqSs18f
         WHaZphub50+inwDaKMiNdE/L6HHp8B88chxBAgCArQphDCLj4yQV7K7u+lnhztwjCO
         UkuNlRIKlGmnLjDVBBmP1QaGPtmqedFPNiKqFfGorsjuOieQM7DLbkx7Tdrj2Pmh6v
         4ofA6zCat+W6g==
Date:   Mon, 11 Jan 2021 11:19:49 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Konstantinos Kaffes <kkaffes@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [QUESTION] TCP connected socket selection
Message-ID: <20210111111949.18236404@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAHAzn3rz5ZH25-53+ijGXhzoV2DqiOhEtV==V2k2R72AwpGAdA@mail.gmail.com>
References: <CAHAzn3rz5ZH25-53+ijGXhzoV2DqiOhEtV==V2k2R72AwpGAdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 11 Jan 2021 10:33:49 -0800 Konstantinos Kaffes wrote:
> Hi everyone,
> 
> It is the first time I am posting to a kernel mailing list so please
> let me know if this question needs to be directed elsewhere.
> 
> I have been using BPF to programmatically steer UDP datagrams to
> sockets using the "sk_reuseport" hook.
> 
> Similarly, I would like to identify request boundaries within a TCP
> stream/connection and programmably forward requests to different
> sockets *after* a connection is established. Is there a way to do that
> in the kernel using BPF?

Sounds like what KCM does.
