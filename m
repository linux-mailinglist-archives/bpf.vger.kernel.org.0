Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256286F630C
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 04:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEDC4O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 22:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEDC4L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 22:56:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB89CE73
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 19:56:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso43520b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 19:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683168970; x=1685760970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+qVTaeUZGIRXgfl1zHi9j22fkQXd0Fx3fQdUDhzSfE=;
        b=A12Je62Nz+ruGgOAizLrRN8TSkroqTljy5WA4yflIqVXcavePCxkHmCd7kAtM0NKJk
         /o2UxMjq6XnrWpgNjEurmhDgbT/2rguN2vwLUsOIA8VnNAD63x/WL93XhrXyYfpRCR8Z
         vc0wPeh8UGbp+e6akuTqyzb//7UpIPgAK8pUscXmRM9113jpbzfknbG17gOPw3kIX/se
         IzalBMA8n0dLMmXuapAIMX95nPkT7Vv9yC19DgpBOa/hOTE7H4WOv55Pa6ZkhQfQuefm
         bQczdSAnP3JBQQny67PGzfjKjvsjTJxPWs6dhpSAg+OdzPpeZvI08r+8elk1iu9uNSoe
         nVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683168970; x=1685760970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+qVTaeUZGIRXgfl1zHi9j22fkQXd0Fx3fQdUDhzSfE=;
        b=WHmHNQlrzkbZQ0dbfl1RpMDlf7Pp0OgEMTQH+GQr7dHOUvjOvZbOLKhSSArI5L5Pug
         f8iZDwgL3HtgzE3Zu5kw07O4Q3iB18AIFzSuLkBSiNxbaMMr8e7TD0/95TIHI7eNfkpN
         /Y1LnAUfMRmZJgHS1kCi+kZRf7iEuip7j3/QXx0Uu+SAP+1FGcdz5XcwNjI843iI5r3r
         W+luSMde+IMfA3pZYvT/VPp1e/kw4OzX7zXcOlpmUUNca6RsO/opl49w/Ek59p/60q7a
         FB02QaE6ZMN++htcI8pDP1Lg5uxc1hCelyLiKQYfePlQYD/osO0wzajkf8w901VJxb5t
         w0rA==
X-Gm-Message-State: AC+VfDzD9IlhZ2R0vAdjMRHdA/YBG6faxNPyz6Ejk8OLxyMmljTfdRj3
        x8GoLDVEqitL3AfLfkp5uCA=
X-Google-Smtp-Source: ACHHUZ6Ho1NtH76IFcGktnUFtSd0Nfj9pXXwPh4qsEdaZmLRQe1BsIiMnWW+WbdEvcHjWL1noidAkA==
X-Received: by 2002:a05:6a00:130a:b0:63a:75a4:b2d4 with SMTP id j10-20020a056a00130a00b0063a75a4b2d4mr674878pfu.24.1683168970188;
        Wed, 03 May 2023 19:56:10 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:396f])
        by smtp.gmail.com with ESMTPSA id v16-20020a056a00149000b0063b7af71b61sm24198574pfu.212.2023.05.03.19.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 19:56:09 -0700 (PDT)
Date:   Wed, 3 May 2023 19:56:07 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/10] bpf: encapsulate precision backtracking
 bookkeeping
Message-ID: <20230504025607.bvzsxqbaqxkxz4xt@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425234911.2113352-4-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 04:49:04PM -0700, Andrii Nakryiko wrote:
> +
> +static inline void bt_reset(struct backtrack_state *bt)
> +{
> +	struct bpf_verifier_env *env = bt->env;

empty line

> +	memset(bt, 0, sizeof(*bt));
> +	bt->env = env;
> +}
