Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1844EB5A
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 17:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhKLQbn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 11:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhKLQbn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 11:31:43 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE57FC061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 08:28:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id n29so16448623wra.11
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jm/9aT9jRBR6ZhI5+PJGLeU9Rc0MA4U4sjZIHizRX90=;
        b=qY3KcSprmORov8UU3vOQUJruSJCu+OT1KY1RTSiBfoB6ltMs/mR7ruQKBDyYycNTOb
         LvrveW+A0nBZzGzWPLKn9f8M2OCVn2sEkz8HiRd9s2EbLqBj8TbkrMuOwtPQ71iJbeF9
         XSm+fHOMriUiPKhT0vMvH+Dod5RlSoPQBZvx7QcnJEpwKkAyttHqDj1n8177ylG12Rtt
         M0psdL+Ewzedqf9WnHmHClOlmkel2NfoZvjno3aisPVk545nQjiHcTXflZS/W/m1XRQg
         WtkoARhjkmgEB4ctZucKYK948vAvB4eyyUBvOnlY3N5VbvTLlVMrxUm5MMN6FWoBZ/tY
         zieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jm/9aT9jRBR6ZhI5+PJGLeU9Rc0MA4U4sjZIHizRX90=;
        b=3aHyAsbdB5C8Bqz3ZSXyw8sPT40zx22rK21j1Q0LDsaPw3fT+LziXohmshRyogXhYk
         zX2VT2d2stWnrp1YFqHlziNL0pS7or3m6Q7TDpBbH4MaFbigq6NYVM7y90GF7Evuofq+
         LVXqKm+xwNWszvfUDXpaKKcK6hUY61+FaGvHkWgg8vuTKyJP8BC3MijXBUtydukToac2
         Qc1V6aAoNUN0DE9q7cYirucIMo48NPTsMNY+8QWkPynZDEj9pAP8WGGNbP/UWp9vyfVD
         8kNBzph7lpH/1/RCr7EPWrxnIEsAUiRfe3GtIYnJUp9U4L6778At2kKgf/Nw3EKXcJHu
         ZsHg==
X-Gm-Message-State: AOAM532Y+gmwb7btJQFFEeLrkuBlwNM+kiaeahOBO5rUm/uH4WIDz08p
        ER0Ax4KB57Cf3WM3+mGk+IM62Q==
X-Google-Smtp-Source: ABdhPJzvGDi2wEcjn4Lt8KrrqyaiABRoewpQXovZoe5KQO+xO9F5kAUc1df+smSlUYAjFKwfVdJL4Q==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr19581890wrw.439.1636734530376;
        Fri, 12 Nov 2021 08:28:50 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id q8sm5973962wrx.71.2021.11.12.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:28:50 -0800 (PST)
Date:   Fri, 12 Nov 2021 16:28:28 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf] tools/runqslower: Fix cross-build
Message-ID: <YY6WLDizLBxnhgnP@myrica>
References: <20211112155128.565680-1-jean-philippe@linaro.org>
 <d3a19501-01ee-a160-2275-c83fb0fb04b7@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a19501-01ee-a160-2275-c83fb0fb04b7@isovalent.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 12, 2021 at 04:17:21PM +0000, Quentin Monnet wrote:
> 2021-11-12 15:51 UTC+0000 ~ Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Commit be79505caf3f ("tools/runqslower: Install libbpf headers when
> > building") uses the target libbpf to build the host bpftool, which
> > doesn't work when cross-building:
> > 
> >   make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/runqslower O=/tmp/runqslower
> >   ...
> >     LINK    /tmp/runqslower/bpftool/bpftool
> >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a(libbpf-in.o): Relocations in generic ELF (EM: 183)
> >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a: error adding symbols: file in wrong format
> >   collect2: error: ld returned 1 exit status
> > 
> > When cross-building, the target architecture differs from the host. The
> > bpftool used for building runqslower is executed on the host, and thus
> > must use a different libbpf than that used for runqslower itself.
> > Remove the LIBBPF_OUTPUT and LIBBPF_DESTDIR parameters, so the bpftool
> > build makes its own library if necessary.
> > 
> > In the selftests, pass the host bpftool, already a prerequisite for the
> > runqslower recipe, as BPFTOOL_OUTPUT. The runqslower Makefile will use
> > the bpftool that's already built for selftests instead of making a new
> > one.
> > 
> > Fixes: be79505caf3f ("tools/runqslower: Install libbpf headers when building")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> I realised too late I should have cc-ed you on those patches, apologies
> for not doing so. Thank you for the fix!

No worries, I usually try to catch build issues in bpf-next but missed it
this time. I'm still slowly working towards getting automated testing on
Arm targets, which will catch regressions quicker.

Thanks,
Jean
