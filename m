Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBAC5B3D79
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiIIQwa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiIIQw3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 12:52:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D091002
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 09:52:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z8so3417702edb.6
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=M5OoAmyemr5hsC9oL21n2+eTtpvlKKFNmSaRw/BibUA=;
        b=nM/uxSQr87jZxyI4QBDNoEN2utcIHX7B8AHn/sMfgD+qFkU064HmX7JxxQM/KsEslC
         C+SNYCPnHOHs8jI1M2DzTG3ChfzV92+nKJBh9EjM2juRX62MyIJgDMow22rMYJWXzlHO
         O5niEiqtpEIHzRDiSs3VS2gnhNTPPHt4QbxBcQLK97OuGa53fas20YUMuMCWuM/9WReb
         ldxvY6GtMTNORpzCkdUIF6iXMcX6IpMJiI04y1PVOrJ9bk+CPATlykUdmjeII0fylAJA
         AwDTcUnUCExmylR9of5v/I+zyONiU/txTkOoO5HJ6xBw8H6BejF+bOkVhQm4+6sUtEBG
         02qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M5OoAmyemr5hsC9oL21n2+eTtpvlKKFNmSaRw/BibUA=;
        b=iRdnfF53vP+qHXaw55F2LBHTTqifDoo916pjEgMDvv0QiX5oPI94TMUfBw8dXpfgqo
         4wOHv1PkHOPaBqxiLIvERz47+BvH91z1UXjP1v4E2pSm2vVYzHf159fFQSnKt3c9uuU/
         kUWRZO4BxuoYO6kRSuevSaFYOHQ1AmVtXCEGetPKpcqT0mPvRJ0N3iarH/ZbGOnhvbD8
         f3M847VViKxL+MD/li4mlE7ilCzqDpdR72mAbslhn7VitIm4RJMwMCDUUCpsF6t6H0AA
         /56BhNwCLATuNYbQ8u+bNvYFJkg2u+mwZpB13H1aUh6XAPVGNsy6oa0dhy94MvPzJxvp
         csaQ==
X-Gm-Message-State: ACgBeo0A727yJSya1nDPViFzHdODoDLQ6zm7un58mQNTxMlF6br3tZwm
        uKjrZoSpa5hPR1CKMl1Trxw=
X-Google-Smtp-Source: AA6agR6lpJvnKzg/MyFIXitknE36y4V9V6RDyU83ZOBDrCy7p3ZhI7UEKwEhwD+k+ZGZDcaVDIOIfg==
X-Received: by 2002:a05:6402:4307:b0:451:106c:ed3b with SMTP id m7-20020a056402430700b00451106ced3bmr3077711edc.342.1662742346895;
        Fri, 09 Sep 2022 09:52:26 -0700 (PDT)
Received: from blondie ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d0d4000000b00450a2c0e22asm620882edo.89.2022.09.09.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:52:26 -0700 (PDT)
Date:   Fri, 9 Sep 2022 19:52:24 +0300
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        andrii@kernel.org, ast@kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH bpf-next v1 4/8] bpf: Add bpf_dynptr_get_size and
 bpf_dynptr_get_offset
Message-ID: <20220909195224.7e7acdcd@blondie>
In-Reply-To: <20220908000254.3079129-5-joannelkoong@gmail.com>
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
        <20220908000254.3079129-5-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed,  7 Sep 2022 17:02:50 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:

> + * long bpf_dynptr_get_offset(struct bpf_dynptr *ptr)
> + *	Description
> + *		Get the offset of the dynptr.
> + *

The offset is an internal thing of the dynptr.

The user may initialize the dynptr and "advance" it using APIs.

Why do we need to expose the internal offset to the ebpf user?
