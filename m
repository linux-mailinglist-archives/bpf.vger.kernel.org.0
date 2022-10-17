Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26EF601B46
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 23:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJQV3u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 17:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJQV3s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 17:29:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EEF1B782
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 14:29:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so13658143wma.3
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mWce0uGLKj6YHEEyq+FFlXRviMA/tfoF+UHZqolrvaY=;
        b=jf2h58Gyz0ac9eiQpWj+Cu3g/ROmmbZTLOTYdDI7Jm6w+0dcai43YfeOPw65oMMusn
         8XsWfrUr+V0fR33z9N0EpJNhweu7SC3lvoxLmRc/T91b5VBVDVzyiBJuKPhpSmbMCSXV
         jTUPAce9hazt+N+h5tEcP1g/Ocreqngnc4BrirmoFwa0V/xNIPEp298mtS2lZCs9tkcY
         tlNj0J3w52oO40OZLZ6gtWNTg7Py+4Nlf1j2oWti3atXEU6tgENrmuBt8omlAep76mzZ
         e3qFnOatiFB9rI3TgJ93JzspJYY8VLFxhJd6ILCAJd+cWVlloGUIFArrC1zdUfImSFCS
         x2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWce0uGLKj6YHEEyq+FFlXRviMA/tfoF+UHZqolrvaY=;
        b=KWxO4WL6eAQX76RQCK7YCacladEVozHI68eZVYxwGIbmUE/psvGsIONat0G+FQfW5l
         hk+FYM3Tr788lxhc5Dpsn0JPBFliX9ntQ+MeQp/j+Nkos6oopKUu7IPirTemn8D0MhcX
         2a58RS2HnJD2zalEic9XnA71hNnw8ttElB9xZ5DP57rC/fmqX36ujQeeGOzCmQV1mYfY
         ptEZXd9JSrZxIW+z1u0YOPRqhtyZKZ+89lEpYYbf9Tj11ZNg7vTumF/Wp9V2UO3V64I2
         rOxTyds3cHn5uJSJIKbyMDmn5AjP1gmlGdrh+DDpDxEs/zd8zuyPuE1ruWttO42HRK6Z
         CBjA==
X-Gm-Message-State: ACrzQf3JQ+UjcA/tHCJ91fy3p48NwjYwzlsnI2Tt9LxGSNbN+279/8gc
        tlLwva6LPXWFmVRLyGGrDfcPQ1ID7Dk=
X-Google-Smtp-Source: AMsMyM7Q17XxsvJnJ/kpdm1et3BLmlWWNZd7stMndJzdthPR3bpwxqLmjvTw4Nqffz86sIh2YSZgFQ==
X-Received: by 2002:a05:600c:1d2a:b0:3c6:b7be:2879 with SMTP id l42-20020a05600c1d2a00b003c6b7be2879mr21869222wms.84.1666042184654;
        Mon, 17 Oct 2022 14:29:44 -0700 (PDT)
Received: from krava ([83.240.63.167])
        by smtp.gmail.com with ESMTPSA id o18-20020adfcf12000000b0022a297950cesm9254375wrj.23.2022.10.17.14.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 14:29:44 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 17 Oct 2022 23:29:40 +0200
To:     Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bernhard Landauer <bernhard@manjaro.org>
Subject: Re: [kernel] 5.10.148 / 5.19.16 - pahole 1.24: BTFIDS
 vmlinux,FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <Y03JRFZIeKR4sNZR@krava>
References: <3f82d342-1c0f-32c4-996e-cc063f872673@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f82d342-1c0f-32c4-996e-cc063f872673@manjaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 15, 2022 at 06:48:03PM +0200, Philip Müller wrote:
> Hi all,
> 
> I just got the following error for 5.10.148 and 5.19.16 when compiling with
> pahole 1.24 on CONFIG_DEBUG_INFO_BTF=y:
> 
>   BTFIDS  vmlinux
> FAILED: load BTF from vmlinux: Invalid argument
> make: *** [Makefile:1168: vmlinux] Error 255
> make: *** Deleting file 'vmlinux'
> 
> similar to:
> https://lore.kernel.org/bpf/20220825171620.cioobudss6ovyrkc@altlinux.org/t/
> 
> For 5.19 I applied the following patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/plain/releases/5.15.66/kbuild-add-skip_encoding_btf_enum64-option-to-pahole.patch
> 
> I wonder what is needed to get 5.10 kernel series compiled and if 5.19
> really doesn't support enum64.

hi,
thanks for the report, I think this is same issue as discussed in here:
  https://lore.kernel.org/bpf/Y02Yv%2FubuCtVhtZk@dev-arch.thelio-3990X/

I'll send 5.10 backport and there's already fix for 5.19 on the list:
  https://lore.kernel.org/bpf/20220916171234.841556-1-yakoyoku@gmail.com/

thanks
jirka
