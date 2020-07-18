Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C64224D74
	for <lists+bpf@lfdr.de>; Sat, 18 Jul 2020 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgGRSLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Jul 2020 14:11:15 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36909 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbgGRSLP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 18 Jul 2020 14:11:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5B2705C0106;
        Sat, 18 Jul 2020 14:11:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 18 Jul 2020 14:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=leTxMSxZYI6GaPQrWTsPAI1LVoG
        vJAzLwE9vA1kDEQI=; b=I+9YnZtRC3VjqT7Mrdw6Zu0kF6zS/tMBEOnwidhNj1G
        YmO0Y3Vhfp78VMV99vfHVkzQeeVdqx32TiGOHU8OwEztDBibllF0gJMJ6kvHSvUr
        Dc5Xm/Nni1c6joS1GoRH0YPfHSPg2gA2u+axxgzHa3p6hYeO/2wSe6USAypiZn+N
        PTTlpMTR2OybGACmfgEexvd3NpClLqmg+yJykGS0puu5edAQbtNNZYrY6AXOahSm
        w6379qoAivlRl8DQqn29+tppMYK6euiqO0/iWFwJWrfFI9PxdLi3McbcAJTAev7w
        f/X/Qq8JK++I6NsRc6UtjoAkoLNhdkfBmaRTKouoJUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=leTxMS
        xZYI6GaPQrWTsPAI1LVoGvJAzLwE9vA1kDEQI=; b=nvRMrqu7DgGksClfeheOGs
        cBkJ9t3PYvlP5TUPwXZyMe0b9Km6or7wQmUQ4wGxME/PhCeit0i4CUsDVDBPTi4c
        Et0i1il257vHIG2bW3vogF4nfqyNWVZrMp3VBYtSvXpGH3iAayTUNiy3kez1yfQ8
        BuTKEUHCMq1gtdWnMBGYM6bYkcqxSRUokfLKWyEjgrLjhabtR/KJ3HhdvA289wb0
        etrdWgnp9xySw/KwMKcD6iX5uQEdvb8ir99K+QxqHswxhMqXSLqgCCzY+6C3Rax8
        IXmmw6HSfV7pdUQYRLpv9LfszGKqx9150GaiR9E36V7iDDrem0d+BRvYOUeoXLHg
        ==
X-ME-Sender: <xms:QjsTX5qVEdt-Zx7lT8ZymKJwFZ1f0hDOAQH3IDv0EnkHhkY5_p_O4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfeelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:QjsTX7oq09BXh3cmyP50EX2yMsjhFz42NPmCpEm9_y-H6VtCRzmTjA>
    <xmx:QjsTX2OlJElcdfqda_Bjl2Dkf93-6yedH50TGW4xzccIrw0ZhuxD1A>
    <xmx:QjsTX07JWKd8JhoS7BKMDJ8VEPRSh2ZrPMM2MgJVhiBowFG_5NjKPw>
    <xmx:QjsTX6FZwfohx38GTn8_YzeVb3VLkqHWmtCU3lObn3UY3ATkaaQBXg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3CF93280060;
        Sat, 18 Jul 2020 14:11:13 -0400 (EDT)
Date:   Sat, 18 Jul 2020 20:11:10 +0200
From:   Greg KH <greg@kroah.com>
To:     Venkata Sai Reddy Avuluri <avulurivenkatasaireddy@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Doubt eBPF
Message-ID: <20200718181110.GA273491@kroah.com>
References: <CAJW+K3E-O3-kT_Q3kba_pTmFj7h-LvP01FpTj=4Rv=DX+M3BGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJW+K3E-O3-kT_Q3kba_pTmFj7h-LvP01FpTj=4Rv=DX+M3BGA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 18, 2020 at 10:16:08PM +0530, Venkata Sai Reddy Avuluri wrote:
> Hello,
> 
> I am Sai Reddy  an undergrad student in Rajiv Gandhi University of
> Knowledge Technologies  in Basar, Telangana, India.
> 
> As of now for Summer internship, i am doing in IIT Madras, We are
> working on some message filters.
> 
> My professor questioned my team "How is BPF happening inside the Kernel?"

That really sounds like a homework question, you have the full source,
what is keeping you all from determining this on your own?

thanks,

greg k-h
