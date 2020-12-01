Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20532CA268
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 13:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgLAMPX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 07:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgLAMPX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 07:15:23 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7FC0613D2
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 04:14:43 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so2421751wmd.0
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 04:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1rTErOWq4BazLczHw4DrMHhncARKuQSlTHmfFJkGcB8=;
        b=v906Cy0MJaMm693YSxRi2oUJFFCslK5UhqB60swVdYLuafxe6oZhzXYFALpyPVObCD
         I2ruXztndADxBKB+w8TbRhmratDuc6bw4X9Qst/EOAfOdO18aY04I6wlmzD1fx0+6xIS
         tVvO5LPE1yBBQH0tqGnwBQ7hXP9DMAWbL8QqL1AbHKUN9isVS9YDRHfE/CA78WmotNDI
         pj0YgbGSrF2KCWtmD5vR5hEncx2Fd9dNVzCQ6UHAakG6sD44x+0DAc6VHRXh7h62JAtU
         aaxxRURa2oni63iTH52kGiPbruYNPQOuG1x1+rDLWHRtErohIjF56cV8subv7ek/2t3t
         OYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1rTErOWq4BazLczHw4DrMHhncARKuQSlTHmfFJkGcB8=;
        b=pgG4ckZI1ft7B4XQarNvuSG4OIK4WX7BXqtFY37C5MygpWNwagPwAki/KvM/BqFSzV
         PPBI4TGz7yk9+PJVTvpoGXbjV89r375GuZ2NR7LF8SSAO+q6hCxob/ugDS4iCPONYP1r
         YIzQJ4rdeKHG2oFNGWQ/3E7AjRcUQisKKuQ3fxYbRBIu9uo9sXStJQuWCuNO/3eXLv70
         FMhgnuZcBMN9XSMG1uaD5ynSA94+OQDv5YX8Esk4H6TieOuDEJxsw8CZusRJ787QH+IZ
         bxd6RdscdxO5el/qN5qKtl4skZhCjA9Mu0F2Z2pm5SFEeb7zGDVRYP4lwOylvgg8aEo9
         PVgA==
X-Gm-Message-State: AOAM532q1XFEew0z07qWyzrC02aRxBwvq1lCtt9rONR3RiyVUWvJJV9r
        jF85Ju+t+aZGId92XdGBquPYk1lxQIQZhQ==
X-Google-Smtp-Source: ABdhPJzTXQ8LcIGOtj3LXwvM4prmhSQ/FBPRcdjNTRTkWSj1AnwJ48PvwFrwDGV45EPVhnobzXPQEw==
X-Received: by 2002:a1c:2e16:: with SMTP id u22mr2330149wmu.149.1606824881813;
        Tue, 01 Dec 2020 04:14:41 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id a144sm2964179wmd.47.2020.12.01.04.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:14:41 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:14:37 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: x86: Factor out emission of
 ModR/M for *(reg + off)
Message-ID: <20201201121437.GB2114905@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-2-jackmanb@google.com>
 <20201129011552.jbepegeeo2lqv6ke@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129011552.jbepegeeo2lqv6ke@ast-mbp>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 28, 2020 at 05:15:52PM -0800, Alexei Starovoitov wrote:
> On Fri, Nov 27, 2020 at 05:57:26PM +0000, Brendan Jackman wrote:
> > +/* Emit the ModR/M byte for addressing *(r1 + off) and r2 */
> > +static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
> 
> same concern as in the another patch. If you could avoid intel's puzzling names
> like above it will make reviewing the patch easier.

In this case there is actually a call like

  emit_modrm_dstoff(&prog, src_reg, dst_reg)

So calling the function args dst_reg, src_reg would be misleading.

I could call them ptr_reg and val_reg or something?
