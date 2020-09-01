Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32794259AC3
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 18:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgIAQyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbgIAQxg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 12:53:36 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86555C061245;
        Tue,  1 Sep 2020 09:53:36 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f2so1617646qkh.3;
        Tue, 01 Sep 2020 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bDHOycR99A9fea4oemmH4QsN3Fgy3zwOncJmsbDtx0I=;
        b=W65P9isxjaU67UF2GaDdMWn7ga3uY6NeEuRGkMk/re+HnZwyRpVqsu+IWlPSrDG2IM
         0/3IHymOc2m0aNNGqm4YMfgVnF2RwWXrVOn3BKzWrEY5S1mosXBHqTyuhxKE4VHw3JOp
         MTXSyn8ym331Mu8wFM3+qKs0MnPv5Cl9CFrwZ7lHHy5vDe/X09XjCAwBwFBKo1/6N+gm
         Hlw/XwDXgOHmIj//Xih43U2bjJsqiEa2eB/EeX+KHkne+4kqqnDlpZJ+kO6JWFAyPjPb
         NhFLQepQ7yzp4wjhtNbA6Mb+s7gIJtXwruJ9ZYcRgLD69eiQHjDpD8OmME41rxtrCZ/C
         +4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bDHOycR99A9fea4oemmH4QsN3Fgy3zwOncJmsbDtx0I=;
        b=SzswSAbzQiKtDwCs4BjaHJLSyFZNK6UcMgPZXu273nJULd14VQRqgCOomeV8MCEWX0
         tSlVAAXfTk4wqBFBa6han3LKSytvCvMwDTSCVZ2a3dXisaOhmMD5hMJbkRq4lwOu4KXB
         XWADnDaKxJxgYWrAJhorUYFiupuJ9a4EXQhrVZsCkw8TcVoN+3Rb+jIV5dBy/atz9LbB
         TtVYe3vcYuSf0sDe7TS09XBNoKCqkj0on7kJFAJff99Sntb9lhFwIYh5PVLaH7JjebMn
         /ZpMMVFERyHralwNJs0Sb/VzU2z2AsScHHIHlQ4GZZBh4D73EsWHvA8uYuEmvhiBH/Fv
         StgQ==
X-Gm-Message-State: AOAM532klztztNpfDTaiuLsiS5ECE3w96lREGyCd9JFQcfOrx8Vyo0v7
        r6F/iCp23Tb3PiejREoDCb73nfeB258fdVz2
X-Google-Smtp-Source: ABdhPJw9HPhTkDodABIRBc8d46bnOrovCP+EIN346XQ42BRASH8qYdUER+Jo/+08ALgNJVWRjupGTQ==
X-Received: by 2002:ae9:ef02:: with SMTP id d2mr2839024qkg.7.1598979215611;
        Tue, 01 Sep 2020 09:53:35 -0700 (PDT)
Received: from leah-Ubuntu ([2601:4c3:200:c230:4970:3d06:3c98:c0eb])
        by smtp.gmail.com with ESMTPSA id k185sm2167335qkc.77.2020.09.01.09.53.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 09:53:35 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:53:33 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
Message-ID: <20200901165333.GD5599@leah-Ubuntu>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com>
 <a0a97488-58c7-1f00-c987-d75e1329159c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a97488-58c7-1f00-c987-d75e1329159c@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 17, 2020 at 10:18:47PM +0800, Bob Liu wrote:
> On 8/13/20 12:33 AM, Leah Rumancik wrote:
> > This program type is intended to help filter and monitor IO requests.
> > 
> 
> I was also working on similar tasks.
> 

Thanks for the review Bob. What use cases did you have for your
implementation?
