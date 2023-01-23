Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA87678B40
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 23:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjAWW7y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 17:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjAWW7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 17:59:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76FFEC50
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 14:59:18 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id lp10so9678350pjb.4
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mUw+5qOPqzT0QgGYWK9h2lLMx3Txbd3YBAfPD6m5U1Y=;
        b=rPsxL2bRQ6/nupQU1Jp9WvRQOljLbKsg4RNOh1teS+06dzRYkoC2I9qcbBtrMoiNCv
         irjB7YQ6NiQ2DRUF5jTUW7IhuWrrwAIqiD/1CQAVFhMGXXpv5DMhP5lKRoPBIaSX9tDs
         hbDHplOT2rkDURb9qq/Z/HniFzTY5q9WoJA24r70t2h7rb+yRTLkOSt1FVwas685ICNz
         s/19wELZGfi6rNoJnBwKw07d5u4mqMyow3eZ9MEjL0G/ZME5ozdpQhtGMO1z5QpvyyFw
         v7DP6UGQ+kqUVDL/A6n24L/teWx1X6ibfNObO8Mpe3nTcGk8zOladW+y0mt1Ct2Vg/wM
         6opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUw+5qOPqzT0QgGYWK9h2lLMx3Txbd3YBAfPD6m5U1Y=;
        b=4CWAuUWn2d8kdOnNhp+93Om/UFDgsek91bKRrdEwidAVdSPD0lHhnQxp9tNM+1RY1k
         CSVnJgBGY3i7eHO9QqLfQtEnuU4mEzOXDa5aKRDS4qhPPkpENNCCfxVTGacVSPELsjB0
         1I25AhCECdwdYyipaE4Apb0dhijbyiKY4SPLtTAzJUAn7/EXz2zJsQm6y0R3ufK71m/m
         aXknynpAhUaB010sM8WwpvIbYWYC/rSbksIhdZ14miQSc65Zoa96poWb7y/gd5cqRtWv
         zXw3wVEn5sAypC+TiIMZ5z2gW1dnSk8eshCMsT7SDrUfjvL/aLHNPO0AsVDz8+65917W
         D9cg==
X-Gm-Message-State: AFqh2kqP/m6PSumsXcMI8JDVQf8Q9gghHB96n+cx4tYpmX2LA+f5NPlH
        fqaUOLLUvfg00ESmVnQkIvxXddGef/EqN1wIzSrdkQ==
X-Google-Smtp-Source: AMrXdXtO0XFUkvEXzJzoxIe3sgPAsDPvPugKrLNWr7lWrmNPcEzij5QlGnC3yuGEkU8DQU1ly+mfyQyI7Tdphp++Z5E=
X-Received: by 2002:a17:90a:2c4d:b0:229:2410:ef30 with SMTP id
 p13-20020a17090a2c4d00b002292410ef30mr2830399pjm.66.1674514748780; Mon, 23
 Jan 2023 14:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20230124094403.76e0011f@canb.auug.org.au>
In-Reply-To: <20230124094403.76e0011f@canb.auug.org.au>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 23 Jan 2023 14:58:56 -0800
Message-ID: <CAKH8qBvO3QiR9tvu6=ic-A79O5qp8=WMSL8VR6sCDvO4cmOKqg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 2:44 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/offload.c
>
> between commit:
>
>   ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
>
> from Linus' tree and commit:
>
>   89bbc53a4dbb ("bpf: Reshuffle some parts of bpf/offload.c")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Yeah, that looks like a correct resolution, thank you!
Not sure what would've been the correct way to handle it in bpf-next
(except waiting for bpf tree to be merged)?

> --
> Cheers,
> Stephen Rothwell
>
> diff --cc kernel/bpf/offload.c
> index 190d9f9dc987,e87cab2ed710..000000000000
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@@ -75,20 -74,124 +74,121 @@@ bpf_offload_find_netdev(struct net_devi
>         return rhashtable_lookup_fast(&offdevs, &netdev, offdevs_params);
>   }
>
> - int bpf_prog_offload_init(struct bpf_prog *prog, union bpf_attr *attr)
> + static int __bpf_offload_dev_netdev_register(struct bpf_offload_dev *offdev,
> +                                            struct net_device *netdev)
>   {
>         struct bpf_offload_netdev *ondev;
> -       struct bpf_prog_offload *offload;
>         int err;
>
> -       if (attr->prog_type != BPF_PROG_TYPE_SCHED_CLS &&
> -           attr->prog_type != BPF_PROG_TYPE_XDP)
> -               return -EINVAL;
> +       ondev = kzalloc(sizeof(*ondev), GFP_KERNEL);
> +       if (!ondev)
> +               return -ENOMEM;
>
> -       if (attr->prog_flags)
> -               return -EINVAL;
> +       ondev->netdev = netdev;
> +       ondev->offdev = offdev;
> +       INIT_LIST_HEAD(&ondev->progs);
> +       INIT_LIST_HEAD(&ondev->maps);
> +
> +       err = rhashtable_insert_fast(&offdevs, &ondev->l, offdevs_params);
> +       if (err) {
> +               netdev_warn(netdev, "failed to register for BPF offload\n");
> +               goto err_free;
> +       }
> +
> +       if (offdev)
> +               list_add(&ondev->offdev_netdevs, &offdev->netdevs);
> +       return 0;
> +
> + err_free:
> +       kfree(ondev);
> +       return err;
> + }
> +
> + static void __bpf_prog_offload_destroy(struct bpf_prog *prog)
> + {
> +       struct bpf_prog_offload *offload = prog->aux->offload;
> +
> +       if (offload->dev_state)
> +               offload->offdev->ops->destroy(prog);
> +
>  -      /* Make sure BPF_PROG_GET_NEXT_ID can't find this dead program */
>  -      bpf_prog_free_id(prog, true);
>  -
> +       list_del_init(&offload->offloads);
> +       kfree(offload);
> +       prog->aux->offload = NULL;
> + }
> +
> + static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
> +                              enum bpf_netdev_command cmd)
> + {
> +       struct netdev_bpf data = {};
> +       struct net_device *netdev;
> +
> +       ASSERT_RTNL();
> +
> +       data.command = cmd;
> +       data.offmap = offmap;
> +       /* Caller must make sure netdev is valid */
> +       netdev = offmap->netdev;
> +
> +       return netdev->netdev_ops->ndo_bpf(netdev, &data);
> + }
> +
> + static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
> + {
> +       WARN_ON(bpf_map_offload_ndo(offmap, BPF_OFFLOAD_MAP_FREE));
> +       /* Make sure BPF_MAP_GET_NEXT_ID can't find this dead map */
> +       bpf_map_free_id(&offmap->map, true);
> +       list_del_init(&offmap->offloads);
> +       offmap->netdev = NULL;
> + }
> +
> + static void __bpf_offload_dev_netdev_unregister(struct bpf_offload_dev *offdev,
> +                                               struct net_device *netdev)
> + {
> +       struct bpf_offload_netdev *ondev, *altdev = NULL;
> +       struct bpf_offloaded_map *offmap, *mtmp;
> +       struct bpf_prog_offload *offload, *ptmp;
> +
> +       ASSERT_RTNL();
> +
> +       ondev = rhashtable_lookup_fast(&offdevs, &netdev, offdevs_params);
> +       if (WARN_ON(!ondev))
> +               return;
> +
> +       WARN_ON(rhashtable_remove_fast(&offdevs, &ondev->l, offdevs_params));
> +
> +       /* Try to move the objects to another netdev of the device */
> +       if (offdev) {
> +               list_del(&ondev->offdev_netdevs);
> +               altdev = list_first_entry_or_null(&offdev->netdevs,
> +                                                 struct bpf_offload_netdev,
> +                                                 offdev_netdevs);
> +       }
> +
> +       if (altdev) {
> +               list_for_each_entry(offload, &ondev->progs, offloads)
> +                       offload->netdev = altdev->netdev;
> +               list_splice_init(&ondev->progs, &altdev->progs);
> +
> +               list_for_each_entry(offmap, &ondev->maps, offloads)
> +                       offmap->netdev = altdev->netdev;
> +               list_splice_init(&ondev->maps, &altdev->maps);
> +       } else {
> +               list_for_each_entry_safe(offload, ptmp, &ondev->progs, offloads)
> +                       __bpf_prog_offload_destroy(offload->prog);
> +               list_for_each_entry_safe(offmap, mtmp, &ondev->maps, offloads)
> +                       __bpf_map_offload_destroy(offmap);
> +       }
> +
> +       WARN_ON(!list_empty(&ondev->progs));
> +       WARN_ON(!list_empty(&ondev->maps));
> +       kfree(ondev);
> + }
> +
> + static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *netdev)
> + {
> +       struct bpf_offload_netdev *ondev;
> +       struct bpf_prog_offload *offload;
> +       int err;
>
>         offload = kzalloc(sizeof(*offload), GFP_USER);
>         if (!offload)
