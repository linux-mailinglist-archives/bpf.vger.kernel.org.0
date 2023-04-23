Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1542C6EC069
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDWOdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWOdY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 10:33:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5524A1B6
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 07:33:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a66e7a52d3so28757255ad.0
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682260403; x=1684852403;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ITY5aJv69KGP30OnYEJXVzRwR4u25/o3s+tam+7eO4=;
        b=TApT87yuX5Mfi6ullA/Wg0EZ2QlsIyQc90duol+N1sUEQSkfck3mQz9ZY/uAxX7q3C
         WwulBYqXcmHCJs+nxp38e2/+sIXrnTOBGyCpKJMnGvIZHySAcA/pMGLkJEeaziCBSnd0
         XuJJctr64RBgI2EvUHPBHBnekVr4LpdVovots8YeJB2TB6sCis6si5EV6zHd9I+pnPP7
         CMCWvANGT/YaGxqgp3U5LOOTS7GUCnhswjIYQqtLLNmY3p77rM7C+0Vk1ay+qPzjIqTZ
         iy2LIyANbdoyc3lkakqq9wnBgPl6xleT+A+VrQvns58gTfDwDGRmHF/asUKgh4W1O6aS
         09vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682260403; x=1684852403;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ITY5aJv69KGP30OnYEJXVzRwR4u25/o3s+tam+7eO4=;
        b=K02J6rAnFYOoJ3XYw7sifWNUet939z1rRgIYEBOAzv+Q2zc9StLS/UUPbeIwHTEUsX
         QE1MjUUsBlNL9hA2YlQefsH9HeCK6tRbBF3XRQUyF65PWcKqm2gdb97ExEDBvhE54nwe
         ZsQiTpAZMAcHP7WY0Hvnk/tcDZLh5jbZ7oCyotJIqzzQ1/oWjJbdEnDzTheECdOSLerI
         PaButZaPsbf3/WpEIZWYmVcWcVdAI7r49y6u6GULiI/VRVFaWLWwGkWo4Q+dxYfc76ST
         U6PmXpf3CUJIQExzzeJISALVJvOYOklFYPuh7WBAd9Rbohg0D9cnXD0QW72GNZ2xQW66
         6oqg==
X-Gm-Message-State: AAQBX9e5A7FaaZii7CpaoDfS2TzXuahM6QWcrvgPqxvthUYsOWxl4VM4
        A1m/0DCNPpAVSPwkCeB00Mg=
X-Google-Smtp-Source: AKy350amA68R+maUV+QqbYVFhbnmH5cXDhmko+0qlVQsz5hqKCDuveJbvsKNw+1po+/VkCG4FpKOtw==
X-Received: by 2002:a17:902:d582:b0:1a9:20ea:f49b with SMTP id k2-20020a170902d58200b001a920eaf49bmr12133963plh.24.1682260402684;
        Sun, 23 Apr 2023 07:33:22 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:5905:623a:c41:59e1])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001a6b5d569fesm5132965plz.215.2023.04.23.07.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:33:22 -0700 (PDT)
Date:   Sun, 23 Apr 2023 07:33:20 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, yhs@meta.com,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>,
        Quentin Monnet <quentin@isovalent.com>
Message-ID: <644541b078b3f_19af0208e5@john.notmuch>
In-Reply-To: <20230421214131.352662-1-kuifeng@meta.com>
References: <20230421214131.352662-1-kuifeng@meta.com>
Subject: RE: [PATCH bpf-next v4] bpftool: Show map IDs along with struct_ops
 links.
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Kui-Feng Lee wrote:
> A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
> struct_ops to links. (226bc6ae6405) It would be helpful for users to
> know which map is associated with the link.
> 
> The assumption was that every link is associated with a BPF program, but
> this does not hold true for struct_ops. It would be better to display
> map_id instead of prog_id for struct_ops links. However, some tools may
> rely on the old assumption and need a prog_id.  The discussion on the
> mailing list suggests that tools should parse JSON format. We will maintain
> the existing JSON format by adding a map_id without removing prog_id. As
> for plain text format, we will remove prog_id from the header line and add
> a map_id for struct_ops links.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> ---

LGTM

Acked-by: John Fastabend <john.fastabend@gmail.com>
