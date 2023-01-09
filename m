Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF6A662BED
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 18:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjAIQ6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 11:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjAIQ6E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 11:58:04 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8121DF06
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 08:58:01 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d3so10145650plr.10
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 08:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3xqJBrd6SPYL67jOzvT5AW+KJMn9P6DkyZAxHWX4fqU=;
        b=O//F0/IpFuJH/WBrJ4VFUD3peIS7QcRdIWKLxD+RaMVR+DbYufEp810lteqsddLXcD
         2vkO4i0XZ/hqNgeChkFEgNug1MbJqh2h1n0D4fcqPqBMBb1ZPwzaPOLerUtT3pTxg0Ve
         n4O07j73p2Jkwshd3dYPtUlLRTWH7UhiFgQqaUerJ7Ul2Y7O4YL92Bo4DwGFarE2m9YM
         Wnbq+xmffxCI3MkvS5OoTs9Mlts6ft8c8N1IxkrknqPhVpPP1GRz4QyGf+fI4bCFwX8v
         g8BtXuS7crLsyPFFm+8msRfjBa4v8CTAxg/8ceqhlKihnUs26fvhRzJTQb3410rWgqs6
         qg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xqJBrd6SPYL67jOzvT5AW+KJMn9P6DkyZAxHWX4fqU=;
        b=GNei7c+Hrc3o/5MjX77G5jmgxKD8aM0x81+g6JouEOrUxLpCE/1xXwlK7tIc+8SeKs
         nZt8jHqyauA81rLdVkmWFYxaBAWM9iJwa3VTXkn0OEpNHkQ1VDbVcIhh9d9yfbWW9okm
         t6cAU5qGuD9vEu415l+sty4QxZ/9eZNGxgds1osy0ImPoTcZ9KRJkCO3MAG9SuLBywVU
         2vr/4L47GLH/z+kFldIZ90MDKVzlhcwR/BXtzOS+52GLoIL7/NpyqI3fsP3TCK7M/hc/
         Z+6wnwPbdN3J+A5pFsxhhJAFzuOJ2u+fGXJg8Va+fVKytxfKxGUF8tBK9lywATJKADyz
         70Sw==
X-Gm-Message-State: AFqh2kri/OLvy7StdFHYOE3i8U07WEeznHwzj0h/QnpSDrVf/VkuE4rb
        vO+KSmMG8upxBB3A65ons3Z+zuMt5plx4BzOE7zh
X-Google-Smtp-Source: AMrXdXueZbocE48hvD/IK37nUmWMp5nRT6GclnMQhuOkpzqXsL2Ygh1NMZyNVy120e3BLbxPL0tjYgqUj5lSPi4mLgk=
X-Received: by 2002:a17:90b:2352:b0:226:b6e7:aedb with SMTP id
 ms18-20020a17090b235200b00226b6e7aedbmr1995334pjb.69.1673283481164; Mon, 09
 Jan 2023 08:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20230106154400.74211-1-paul@paul-moore.com> <20230106154400.74211-2-paul@paul-moore.com>
 <CAKH8qBtr3A+EH2J6DCaVbgoGMetKbLUOQ8ZF=cJSFd8ym-0vxw@mail.gmail.com>
In-Reply-To: <CAKH8qBtr3A+EH2J6DCaVbgoGMetKbLUOQ8ZF=cJSFd8ym-0vxw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Jan 2023 11:57:57 -0500
Message-ID: <CAHC9VhRLSAbSHE1nTGwjuUdMtfwTsRVjhV+eznWRw5Ju_qgDAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] bpf: remove the do_idr_lock parameter from bpf_prog_free_id()
To:     Stanislav Fomichev <sdf@google.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Burn Alting <burn.alting@iinet.net.au>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 6, 2023 at 2:45 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Fri, Jan 6, 2023 at 7:44 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > It was determined that the do_idr_lock parameter to
> > bpf_prog_free_id() was not necessary as it should always be true.
> >
> > Suggested-by: Stanislav Fomichev <sdf@google.com>
>
> nit: I believe it's been suggested several times by different people

As much as I would like to follow all of the kernel relevant mailing
lists, I'm short about 30hrs in a day to do that, and you were the
first one I saw suggesting that change :)

> Acked-by: Stanislav Fomichev <sdf@google.com>

-- 
paul-moore.com
