Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7816F6F90
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 18:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjEDQEq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 12:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjEDQEp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 12:04:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5055BD
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 09:04:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6434e65d808so816799b3a.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683216282; x=1685808282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bG9TXQvzrmTzIbpWPfiXuwlL/ugj5fSAWAVc2v92g2I=;
        b=HUqqxN1DJErTcaXKJROCXbj4zR1/AxeEbRCh2mdYwi5+fBBSYlMTfFw5CGTqvvOT3F
         ZooLuM+YaEZGr4AypZYV3qwdcg03yH7l6nmzsOZ/HXf/Sle3Ek7tYwaklfA+izKMNLSm
         PqdpIqk2SoZ2k5fcjk3dtZWym3A09IYIRmqR3JWO2M5dlZN9ylX23U8bYEVVl1vgLkUN
         TkzsGZGMcRAxP2cUM/iTzjjfpWOES+fwrtvcpaYNA2Ls3TE1lZlKbq9YdzIc0eFgToSU
         +7fzd4jSReYNOtkoIu+U/M9dfGVt8e8tRUgpE8MG9aIkAmeigl898bHWXtJAJtD3RUaU
         gq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683216282; x=1685808282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG9TXQvzrmTzIbpWPfiXuwlL/ugj5fSAWAVc2v92g2I=;
        b=b5CNW9TRWqSuqQYrHThb1vdWESgBKhrh32Zvp1AkLwv0w06nkdTpcFjDcoNv2ziQ5w
         jJbipEgcYS/cjdlv9DvUJxYL7MUXKquFvDLMVQZKppF6Zxo35UgGNuLPNxWRj3FUoNQ9
         SWJm3V7cqTyvj4vuQVX8v5sFavXiKZm3sGb4eYH9k8rHhLD/Y3zcIQ8f7OJqDb490Bgj
         a2S9YNyAxE0uLpWhqIXzXjs7W8RUoDOXIfcgimXU/rVa1cNaaQc3lPyBTcotMAjtbMqw
         JpcOMfKAViHP7SUMvwEBnunGBHRE+1lJyKf/MwU12y8SHkv/Z+VJxn6eTyEk9+P7QfP+
         0C2A==
X-Gm-Message-State: AC+VfDzRx5rCaV6jDArloPjue+YaCgggxy1fuz3By51texE3nvkrpPOQ
        S1lHEVlHKhvadT2/egtklrsLHP11mJo=
X-Google-Smtp-Source: ACHHUZ4/Rz7zqZytG6L6wLQcLo8xODh+FGKdpwfMfChUIicQuGwKiW8hKl5jgiJmGiD78lvWoLfNzw==
X-Received: by 2002:a05:6a00:1a90:b0:640:f2a8:78d5 with SMTP id e16-20020a056a001a9000b00640f2a878d5mr3211983pfv.33.1683216282040;
        Thu, 04 May 2023 09:04:42 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:168f])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7808f000000b006437c0edf9csm1668504pff.16.2023.05.04.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:04:41 -0700 (PDT)
Date:   Thu, 4 May 2023 09:04:38 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 06/10] bpf: fix propagate_precision() logic for
 inner frames
Message-ID: <20230504160438.l7kkq6eexeudchrk@MacBook-Pro-6.local>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-7-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425234911.2113352-7-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 04:49:07PM -0700, Andrii Nakryiko wrote:
> +
> +	err = mark_chain_precision_batch(env, old->curframe);

I think I'm sort-of starting to get it, but
above should be env->cur_state->curframe instead of old->curframe, no?
mark_chain_precision_batch will be using branch history of current frame.
__mark_chain_precision() always operates on
  struct bpf_verifier_state *st = env->cur_state;
