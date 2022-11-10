Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBA16247D8
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 18:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKJRC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 12:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiKJRC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 12:02:58 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296FF2A95E
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 09:02:57 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h193so2362491pgc.10
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 09:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7ZZANykEz0NXb6a32jbEP6HPBEBuliW0zDPHe4LN1g=;
        b=kC/8B9lKghWKUjK/lIqJ7lmJPH/l8cgeftPIPfKXvI+q6VkRVQdtKdBnJ487jmEbhS
         XvYtA1HwEMlIuXNaz6BXwEMATakEOOzoI8URm8iHLJFdKT2oHBxj37RtzVVwnYm8Rw7P
         whrnoL3u9RCaH0TybNxxvlqbeWeozZhGCALr73BcogX8REHeEpLDf95btqCtx6jaIp7F
         wyMDVJG9kfvXRg840jSoz242xDwWP5qZzkE6mWMrOTBDl/AqWwfr5sz6q67reVEEBlfH
         N12hcEwjW9S2wrnEwLB+gEcXEdfjP0Qt37BgI/xsJyqv1/6QUfoD8WQ0cOHHyRlzyW/i
         7q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7ZZANykEz0NXb6a32jbEP6HPBEBuliW0zDPHe4LN1g=;
        b=x2VBK4GXvKBmaER58l1r9xSNEZl2P+A+Dyw/3XNSmHpMpJzL0hH0fEvuCIvAgjVdcN
         TBKNf/MGxmNupD2wg/aTgkMUrIWosV17s3fXTzX4LKMbkuM4LgvjminUdHgnHo6d5EWg
         hyOgD7fsZPxZE7OjPtx6O8Yt8fdF3J/K4yWa1EXe5OQhmj00mg3dHxYhYk1OoUpNZNf9
         oP4gd1MV9N+nsRz/SHTv+SpQfFjZhfXp/U2przuem42SM3VpUtEHXayfq54zlIzEMzf4
         J6Gk5vR5puPNzzclZBubQ/gh8pP2Hjgd3W8D44bw1j7om73ONylIz5hSdB/pw1ARgV2+
         TlJA==
X-Gm-Message-State: ACrzQf1+8gGcxlxDC8T4wy/M2j0cQa8wzwydNMpS3XnAgWh1fDFqZ0rt
        IDxISmOd6wby/dbg1N9I70mIVZXzTQc=
X-Google-Smtp-Source: AMsMyM78gNgEQP6gglO39Rcbl60rBZYZRUAcl+fdSpSEl43RaOoSjTj/3yOCaEMrqBy64MDp23MX7Q==
X-Received: by 2002:a63:5115:0:b0:46f:eb27:25ca with SMTP id f21-20020a635115000000b0046feb2725camr2917909pgb.415.1668099776486;
        Thu, 10 Nov 2022 09:02:56 -0800 (PST)
Received: from localhost ([98.97.42.169])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902680800b001785a72d285sm4436196plk.48.2022.11.10.09.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:02:55 -0800 (PST)
Date:   Thu, 10 Nov 2022 09:02:51 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@meta.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Message-ID: <636d2ebbdef56_145693208d6@john.notmuch>
In-Reply-To: <45abee73-850d-9563-2d70-46aec79cb054@meta.com>
References: <20221109184039.3514033-1-cerasuolodomenico@gmail.com>
 <45abee73-850d-9563-2d70-46aec79cb054@meta.com>
Subject: Re: [PATCH bpf-next v2] selftests: fix test group SKIPPED result
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> 
> 
> On 11/9/22 10:40 AM, Domenico Cerasuolo wrote:
> > From: Domenico Cerasuolo <dceras@meta.com>
> > 
> > When showing the result of a test group, if one
> > of the subtests was skipped, while still having
> > passing subtests, the group result was marked as
> > SKIP. E.g.:
> > 
> > 223/1   usdt/basic:SKIP
> > 223/2   usdt/multispec:OK
> > 223/3   usdt/urand_auto_attach:OK
> > 223/4   usdt/urand_pid_attach:OK
> > 223     usdt:SKIP
> > 
> > The test result of usdt in the example above
> > should be OK instead of SKIP, because the test
> > group did have passing tests and it would be
> > considered in "normal" state.
> > 
> > With this change, only if all of the subtests
> > were skipped, the group test is marked as SKIP.
> > When only some of the subtests are skipped, a
> > more detailed result is given, stating how
> > many of the subtests were skipped. E.g:
> > 
> > 223/1   usdt/basic:SKIP
> > 223/2   usdt/multispec:OK
> > 223/3   usdt/urand_auto_attach:OK
> > 223/4   usdt/urand_pid_attach:OK
> > 223     usdt:OK (SKIP: 1/4)
> > 
> > changes from v1:
> > - added (SKIP: x/y) to OK tests that have
> > SKIP subtests
> > - merged print_test_name and test_result
> > functions as they were always called together
> > 
> > Signed-off-by: Domenico Cerasuolo <dceras@meta.com>
> 
> Acked-by: Yonghong Song <yhs@fb.com>

Late but Ack from me as well this resolves my original comment.

Thanks!

Acked-by: John Fastabend <john.fastabend@gmail.com>
