Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F19C6173B5
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 02:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKCBXm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 21:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCBXl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 21:23:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100962D7
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 18:23:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k15so294734pfg.2
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 18:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=870/8kpM9K0R8ccX6XhaBcWMA9RA/g+KUdyXWIrIHRc=;
        b=gMQpS+WkqnqfrpMDt/WVHMosgZLKY58GWM8gr/8o1uAOUp9SVzXb2/RLoaTr3UWAj4
         kWaXH1qemMSk8JcVnrKYwuZC0QM4Yf/g6/Z5AsQ9ingrJnFfldCsrJGp8PkUMoFoT3JV
         mGr3YT8w9W96AirBTWXGb6CNSM9lG9O7xtYo6WADjYWR8jzPUlwy/SeqJb1peZ3DM2Qm
         OqX6uWu8zJZW7Z+dUiDdZETe4C01jmrTbAISPKW7ApeQaZl5ddigQCMpJWqqP0/p9OWd
         RYf8AwSxeVBc5b+Ds99eqxa1thJ9e+92hlo7oDJyzcZRAsvyycPzOi/6yRTG3vOzTZo1
         2hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=870/8kpM9K0R8ccX6XhaBcWMA9RA/g+KUdyXWIrIHRc=;
        b=DjRsjwTMpYfeXVvkLZ/XpBmPa3SSNw2h24IhpkBZK3gN3lBQngkKQl2o1mdgXFIlTm
         l4I8uHovN4Ou4Ag8ZN3SQCnV9sm2sCnmM9jBVYQi9tFNbxgApINi1S6O1scErYV/xHWG
         awHjWU7g8BsvmLZBv9PTj0o3crLHzLxOmOeHOTjyTxL2egw6bF6iLkcXobjQR/lC7Luy
         3t9I4PzzlFcU05vz52m+DCfxA9h4IzK8voMzGgaHTgoy9LsYF0X4TR39aKG0h4Attnnq
         pmU+Ru2Udd7tXIGPaUMS+cp6fermobkLuKoBVNjBkqTKaP8+Yz/8l8oNxFYmNZUbbVjf
         dGdA==
X-Gm-Message-State: ACrzQf0ULvpZ+3KW6RUeWFxuDZTXvNRXqLYzh9Fsl0GDWc9gXqQNcTd8
        Vrawbx+XXnJ04OoYqkgN2P82Fv3jFD8=
X-Google-Smtp-Source: AMsMyM5/neAZK4WFAkQM4VM3zFMQYM+bkcRQGH1zzyT6h8Gcsr3f3dngzREJcWcTLvJpi/Mp28zETg==
X-Received: by 2002:a63:8942:0:b0:46e:c02e:2eaf with SMTP id v63-20020a638942000000b0046ec02e2eafmr24391802pgd.394.1667438619749;
        Wed, 02 Nov 2022 18:23:39 -0700 (PDT)
Received: from MacBook-Pro-5.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:2035])
        by smtp.gmail.com with ESMTPSA id v4-20020aa799c4000000b0056c7b49a011sm9083190pfi.76.2022.11.02.18.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:23:39 -0700 (PDT)
Date:   Wed, 2 Nov 2022 18:23:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/6] bpf: propagate precision in ALU/ALU64
 operations
Message-ID: <20221103012336.2snc6vptsj335dkd@MacBook-Pro-5.local.dhcp.thefacebook.com>
References: <20221102062221.2019833-1-andrii@kernel.org>
 <20221102062221.2019833-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102062221.2019833-2-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 01, 2022 at 11:22:16PM -0700, Andrii Nakryiko wrote:
> When processing ALU/ALU64 operations (apart from BPF_MOV, which is
> handled correctly already; and BPF_NEG and BPF_END are special and don't
> have source register), if destination register is already marked
> precise, this causes problem with potentially missing precision tracking
> for the source register. E.g., when we have r1 >>= r5 and r1 is marked
> precise, but r5 isn't, this will lead to r5 staying as imprecise. This
> is due to the precision backtracking logic stopping early when it sees
> r1 is already marked precise. If r1 wasn't precise, we'd keep
> backtracking and would add r5 to the set of registers that need to be
> marked precise. So there is a discrepancy here which can lead to invalid
> and incompatible states matched due to lack of precision marking on r5.
> If r1 wasn't precise, precision backtracking would correctly mark both
> r1 and r5 as precise.
> 
> This is simple to fix, luckily. If destination register is already
> precise, we need to propagate precision to source register (if it is
> SCALAR). This is similar to `reg += scalar` handling case, so nothing
> conceptually new here.

Could you rephrase the above paragraph to make it clear that the fix
is not in backtracking logic, but in nomral forward simulating part of the verifier.
After reading the 1st paragraph it sounds that backtracking is wrong,
but it's the normal pass that is missing precisions propagation.
Also instead of "similar to `reg += scalar`" could you explicitly mention
that pointer += scalar and scalar += pointer correctly propagate
precisions of scalars. It's the scalar += scalar case that was incomplete.

Other than that it's a great fix!
