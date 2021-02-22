Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BE322094
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 21:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhBVUD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 15:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhBVUD4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 15:03:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D184AC061786
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 12:03:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a207so405572wmd.1
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 12:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gPN/WN2fGLJv23eKzFySfQRmwGSKLcUQczPD3eNagSE=;
        b=dkyaV+zciqTrT5UeyfWvb+2c7OxSl8o+YlhSqPD7THIiFTVflsibqOXxLGpYiRyeps
         aXg2QE2T9vEOi+/4UqNpFrvvmNKDNFzJzGhOA2h2/Hf+yZq4C4Cxj6GAUGUyOUaeY4l2
         Njzzu54IB2WIJoIqMxs0iprxOBtCTl7uMtGlEcPE722DXWLfMTPdp4zeCO4guNpTkUuG
         43bXr+r+lyHAzdACz6qO5t5g4/jVv04Xtn3Wlxy6jf2Wqx0goX66OM5S/UgFl2chtn4R
         itrdKiZffsGeKOxney6dWK93FBJ1ECfNbY63k8lWygBUAY4wstbTauSJ4GDSHuT38z8O
         xmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gPN/WN2fGLJv23eKzFySfQRmwGSKLcUQczPD3eNagSE=;
        b=DBbvrPu/djQ88xIePn1oFRmgizYQ9AdQ1TO+/7IAO8+RmHizHbi/8JNzOdbccwwBSv
         MblBwkIRxDX83g7vqb0lNortbVzfEtxhEnqbCJlNRM1sOrvo35TzQRYd4KOeqc5g6xSW
         UrqVJ0zVhLSzMjcahIHOC5KKzQNVlajpD9Hq6iYOh27iILI4QzSqPHUfHo+Aj4MiilD1
         hnBBRdS5fgS63aMNRgkPdOMS/PhRAP1sfI/0oP1l8R1JXWAz4jfUV3y0MVerkaFc57sh
         GHHRBnRnSagNetnQMMiOS9ckQPGkzbtFigUjmK1iW+Y4CR5dFQEb06Zd9ziTFC0VvY44
         RriQ==
X-Gm-Message-State: AOAM53276HOkq56dgPjbZzgq86/k6/51hSZjsDscNeRLaBeOroxOSp0w
        1hE5QG87FnloisGdX58ZlloBng==
X-Google-Smtp-Source: ABdhPJylCh3mSXayUwfGS/0WAzl0D98EVgQN64BT7kkcvTn6AlJcRMnOAkoKrCEgzTIb6ZBtL3LmPw==
X-Received: by 2002:a1c:cc08:: with SMTP id h8mr21988755wmb.188.1614024179073;
        Mon, 22 Feb 2021 12:02:59 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id f7sm314375wmh.39.2021.02.22.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:02:58 -0800 (PST)
Date:   Tue, 23 Feb 2021 00:02:57 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, rdna@fb.com
Subject: Re: [PATCH v1 bpf-next] bpf: Drop imprecise log message
Message-ID: <20210222200257.opuifovyvbzbytzt@amnesia>
References: <20210221195729.92278-1-me@ubique.spb.ru>
 <20210222091050.160161-1-me@ubique.spb.ru>
 <20210222193111.3koc5bo3czetwltx@kafai-mbp.dhcp.thefacebook.com>
 <20210222195335.bap6t5qwgvdu5rqm@amnesia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222195335.bap6t5qwgvdu5rqm@amnesia>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 22, 2021 at 11:53:38PM +0400, Dmitrii Banshchikov wrote:
> On Mon, Feb 22, 2021 at 11:31:11AM -0800, Martin KaFai Lau wrote:
> > On Mon, Feb 22, 2021 at 01:10:50PM +0400, Dmitrii Banshchikov wrote:
> > > Now it is possible for global function to have a pointer argument that
> > > points to something different than struct. Drop the irrelevant log
> > > message and keep the logic same.
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > 
> > > Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
> > Should be this: e5069b9c23b3 ("bpf: Support pointers in global func args")?
> 
> Yeah, sorry for it.
> 

Shall I respin it?


-- 

Dmitrii Banshchikov
