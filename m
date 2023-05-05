Return-Path: <bpf+bounces-152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395556F8B1A
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823B21C21A01
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7744DF58;
	Fri,  5 May 2023 21:35:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B3BE73
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:35:41 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CBFE42
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 14:35:40 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e205905d4so2098588a91.0
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683322540; x=1685914540;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrgWMDjgeWFjf0m/7vTw70gyzaur2Y6/xRFZj2OFtmc=;
        b=bTyoy0ptPE1E9uBuhjDj2xH1dQAt66BRriRhFigtrmRCB/Vopxq6+mglUYiWLtfyYg
         HMwrLS7+5yzv6KhSc3wbzGNidEWHpLvndyXwKEIbQb+3CdC44MyGz46jb4PZFYaIjale
         idxERn60ZecQPR5hxMxSrRV5hnqzoWIl425sb7zMgkR4q3eLEDJ8xoduXuXiwRNllaZk
         NMGL4dZ2rXJw0pLRERrIDZ4v6qT4/Hc0jy6JgptBeIOym5EhEnI2IFZ9R4Ymi1rW5A8c
         1IHOZ6uTj+oPXnkRDVVScudS+bUqX6/GwWzg8Mt+xpOq64zx5YyCygLbHMbznBhPnlVC
         UR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683322540; x=1685914540;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hrgWMDjgeWFjf0m/7vTw70gyzaur2Y6/xRFZj2OFtmc=;
        b=bdkby4ACVejHehS6PfhVf99w+toFr08zLtEYrXWMaMwv9mrZv4tSyUVfmaN7Vbsp8A
         PAJaSOdhVS/z3h48moSJRJfbKz4ohXdv+1IfNd9biNcVXnIZlYvTqvS7SXKfNYhfEz+w
         TFDGvPBm4ihyXonABrg9nb9LOP8tAzVfMhH5QpySJmNtE83COjSx5A6Oxv3VSyW1cVqH
         6dZE2FSGJGPNsj1Q55hxfYxiXdi5trc0u1651VwBFWbTMtOkwsjidDH5vWBZ0Rl6dSl9
         J4EUXnlt9+RaEbFnrZbSv6SljSHe71S+Myt+sNDSacEdY4Usahz1ZsJXg/+smHWh88N8
         mKEw==
X-Gm-Message-State: AC+VfDw60qFRf3cojRUowdJRsOrHGLSS3/iU85Go+Kgo4b3aB+f6D4mW
	7tji3856HrbCFWMbTiy5LBWBKWv+ROVuewfyMzzeXEmXZaM73lrtT1LFRbULzPAw2cJXRhjfeCn
	jAuw4WcD4P/x6rirt50oe1wHnVZI3c14qdFHT6PuPWC7ly2umIg==
X-Google-Smtp-Source: ACHHUZ7YzC/zOqtGRFZZotrYL7+dh8vyvetZVVbeiSf93epndNGiWAaKJCEJWteRNYuO3vojyh3yhQY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:93:b0:246:a74f:fd73 with SMTP id
 bb19-20020a17090b009300b00246a74ffd73mr799363pjb.6.1683322539909; Fri, 05 May
 2023 14:35:39 -0700 (PDT)
Date: Fri, 5 May 2023 14:35:38 -0700
In-Reply-To: <CAKH8qBuDzThzDcN6WwyLmD75LSv0zrd-ZiwDMwVmJiQ82DxepQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230505184550.1386802-1-sdf@google.com> <CAKH8qBuDzThzDcN6WwyLmD75LSv0zrd-ZiwDMwVmJiQ82DxepQ@mail.gmail.com>
Message-ID: <ZFV2qq6UdiA6TgG1@google.com>
Subject: Re: [PATCH bpf-next] RFC: bpf: query effective progs without cgroup_mutex
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/05, Stanislav Fomichev wrote:
> On Fri, May 5, 2023 at 11:45=E2=80=AFAM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > We're observing some stalls on the heavily loaded machines
> > in the cgroup_bpf_prog_query path. This is likely due to
> > being blocked on cgroup_mutex.
> >
> > IIUC, the cgroup_mutex is there mostly to protect the non-effective
> > fields (cgrp->bpf.progs) which might be changed by the update path.
> > For the BPF_F_QUERY_EFFECTIVE case, all we need is to rcu_dereference
> > a bunch of pointers (and keep them around for consistency), so
> > let's do it.
> >
> > Sending out as an RFC because it looks a bit ugly. It would also
> > be nice to handle non-effective case locklessly as well, but it
> > might require a larger rework.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>

Ah, that wont work, can't copy to user while holding rcu.

Maybe we can even go as far as converting the progs list to rcu..
This should allow as to drop mutex altogether during the query path.
As long as we return EAGAIN on racy deatach we should be fine it seems.
Will try to play with this idea.

