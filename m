Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1A219C7F
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGIJn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 05:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgGIJn0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 05:43:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B89C08C5CE
        for <bpf@vger.kernel.org>; Thu,  9 Jul 2020 02:43:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so5860768wmm.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2020 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cht/NznGsyhV/VjILZ7KDdK2/MBSjy6wZhcgzjIJzCo=;
        b=MZ4XPBeXJUDIEfOODtbz4jVrmmL/QfudpKaLhWOCKlLgzisiQWqCv10tLVV6400cIH
         2dRDQT5aDnKpw/GuFwZBqFQDl2oKWHI0lTE/yq++BHywB03mePOMHpwO7CMvPDMRBMLP
         wQ4EZyEejYpkEbLPV90CP6L+5k4srdfDVDr6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cht/NznGsyhV/VjILZ7KDdK2/MBSjy6wZhcgzjIJzCo=;
        b=bB0PGr7gw2qaBcjKXwtbgsvy3QZb9blal2lHCzh1aCAa54cym6pqOVpwPklr9F3En/
         h+BZ5Huo8GIMa6GIitLNWeveo0uWZ4SKAuqnUSoX1GHhSG0Ibh3WZR/x729uLqNkMUs5
         Uzfj5cR4fUwj7CYrDySyTtEf6PiDSIaeeqKEIZaQC/gpGJqRV3dVhvAKLpBSEDk+5EY2
         wBCksCW+OefGcAiFV4LBcf2R6h0nD2AaMqgxc6OzK0rsMbxWQ30Y/Od1vWUJJuW8MNVb
         msRO6vmPaSKPJcFTfHgLay+i+KWpBPUeaWMgIf0NWJYM+OgeL3Dc4n0DHxh6Fqke1oNW
         sBlA==
X-Gm-Message-State: AOAM532K21PYPomsRalAvBje5+9HL90gx5dzIFQhnDGjtDxsrnm7XoBm
        9vb5usRSA9g9m8ydIpdsn3qH2w==
X-Google-Smtp-Source: ABdhPJy8EOcTDCXtURXnKBTx5Dn6ijFW3NaePTz2b0DTpkMhuckvt3IMv6aV06oC8GkmXE4KhS9Mcw==
X-Received: by 2002:a1c:9e45:: with SMTP id h66mr13059898wme.15.1594287804037;
        Thu, 09 Jul 2020 02:43:24 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id f9sm4653870wru.47.2020.07.09.02.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 02:43:23 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 9 Jul 2020 11:43:21 +0200
To:     kernel test robot <lkp@intel.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Generalize bpf_sk_storage
Message-ID: <20200709094321.GA3743174@google.com>
References: <20200709005654.3324272-2-kpsingh@chromium.org>
 <202007091053.Se7i8FMj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007091053.Se7i8FMj%lkp@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09-Jul 10:49, kernel test robot wrote:
> Hi KP,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on bpf-next/master]
> 
> url:    https://github.com/0day-ci/linux/commits/KP-Singh/Generalizing-bpf_local_storage/20200709-085810
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: alpha-allyesconfig (attached as .config)
> compiler: alpha-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> net/core/bpf_sk_storage.c:170:6: warning: no previous prototype for 'bpf_sk_storage_free' [-Wmissing-prototypes]
>      170 | void bpf_sk_storage_free(struct sock *sk)

Thanks! Fixed with a missing include to bpf_sk_storage.h in
bpf_sk_storage.c

>          |      ^~~~~~~~~~~~~~~~~~~
> >> net/core/bpf_sk_storage.c:280:5: warning: no previous prototype for 'bpf_sk_storage_clone' [-Wmissing-prototypes]
>      280 | int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>          |     ^~~~~~~~~~~~~~~~~~~~
> >> net/core/bpf_sk_storage.c:401:17: warning: no previous prototype for 'sk_storage_map_alloc' [-Wmissing-prototypes]
>      401 | struct bpf_map *sk_storage_map_alloc(union bpf_attr *attr)
>          |                 ^~~~~~~~~~~~~~~~~~~~

should have been static. Fixed.

> >> net/core/bpf_sk_storage.c:413:6: warning: no previous prototype for 'sk_storage_map_free' [-Wmissing-prototypes]
>      413 | void sk_storage_map_free(struct bpf_map *map)
>          |      ^~~~~~~~~~~~~~~~~~~

Ditto. Fixed.


- KP

> >> net/core/bpf_sk_storage.c:483:6: warning: no previous prototype for 'bpf_sk_storage_diag_free' [-Wmissing-prototypes]
>      483 | void bpf_sk_storage_diag_free(struct bpf_sk_storage_diag *diag)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~
> >> net/core/bpf_sk_storage.c:511:1: warning: no previous prototype for 'bpf_sk_storage_diag_alloc' [-Wmissing-prototypes]
>      511 | bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> net/core/bpf_sk_storage.c:658:5: warning: no previous prototype for 'bpf_sk_storage_diag_put' [-Wmissing-prototypes]
>      658 | int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
>          |     ^~~~~~~~~~~~~~~~~~~~~~~
> 
> vim +/bpf_sk_storage_free +170 net/core/bpf_sk_storage.c
> 
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  168  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  169  /* Called by __sk_destruct() & bpf_sk_storage_clone() */
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26 @170  void bpf_sk_storage_free(struct sock *sk)
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  171  {
> 9af362a775d83f KP Singh           2020-07-09  172  	struct bpf_local_storage_elem *selem;
> 9af362a775d83f KP Singh           2020-07-09  173  	struct bpf_local_storage *sk_storage;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  174  	bool free_sk_storage = false;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  175  	struct hlist_node *n;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  176  
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  177  	rcu_read_lock();
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  178  	sk_storage = rcu_dereference(sk->sk_bpf_storage);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  179  	if (!sk_storage) {
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  180  		rcu_read_unlock();
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  181  		return;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  182  	}
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  183  
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  184  	/* Netiher the bpf_prog nor the bpf-map's syscall
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  185  	 * could be modifying the sk_storage->list now.
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  186  	 * Thus, no elem can be added-to or deleted-from the
> 9af362a775d83f KP Singh           2020-07-09  187  	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  188  	 *
> 9af362a775d83f KP Singh           2020-07-09  189  	 * It is racing with bpf_local_storage_map_free() alone
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  190  	 * when unlinking elem from the sk_storage->list and
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  191  	 * the map's bucket->list.
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  192  	 */
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  193  	raw_spin_lock_bh(&sk_storage->lock);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  194  	hlist_for_each_entry_safe(selem, n, &sk_storage->list, snode) {
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  195  		/* Always unlink from map before unlinking from
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  196  		 * sk_storage.
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  197  		 */
> 9af362a775d83f KP Singh           2020-07-09  198  		bpf_selem_unlink_map(selem);
> 9af362a775d83f KP Singh           2020-07-09  199  		free_sk_storage = bpf_selem_unlink(sk_storage, selem, true);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  200  	}
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  201  	raw_spin_unlock_bh(&sk_storage->lock);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  202  	rcu_read_unlock();
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  203  
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  204  	if (free_sk_storage)
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  205  		kfree_rcu(sk_storage, rcu);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  206  }
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  207  
> 9af362a775d83f KP Singh           2020-07-09  208  static void *bpf_sk_storage_lookup_elem(struct bpf_map *map, void *key)
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  209  {
> 9af362a775d83f KP Singh           2020-07-09  210  	struct bpf_local_storage_data *sdata;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  211  	struct socket *sock;
> 9af362a775d83f KP Singh           2020-07-09  212  	int fd, err = -EINVAL;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  213  
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  214  	fd = *(int *)key;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  215  	sock = sockfd_lookup(fd, &err);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  216  	if (sock) {
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  217  		sdata = sk_storage_lookup(sock->sk, map, true);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  218  		sockfd_put(sock);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  219  		return sdata ? sdata->data : NULL;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  220  	}
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  221  
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  222  	return ERR_PTR(err);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  223  }
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  224  
> 9af362a775d83f KP Singh           2020-07-09  225  static int bpf_sk_storage_update_elem(struct bpf_map *map, void *key,
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  226  				      void *value, u64 map_flags)
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  227  {
> 9af362a775d83f KP Singh           2020-07-09  228  	struct bpf_local_storage_data *sdata;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  229  	struct socket *sock;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  230  	int fd, err;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  231  
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  232  	fd = *(int *)key;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  233  	sock = sockfd_lookup(fd, &err);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  234  	if (sock) {
> 9af362a775d83f KP Singh           2020-07-09  235  		sdata = map->ops->map_local_storage_update(sock->sk, map, value,
> 9af362a775d83f KP Singh           2020-07-09  236  							   map_flags);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  237  		sockfd_put(sock);
> 71f150f4c2af5f YueHaibing         2019-04-29  238  		return PTR_ERR_OR_ZERO(sdata);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  239  	}
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  240  
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  241  	return err;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  242  }
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  243  
> 9af362a775d83f KP Singh           2020-07-09  244  static int bpf_sk_storage_delete_elem(struct bpf_map *map, void *key)
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  245  {
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  246  	struct socket *sock;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  247  	int fd, err;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  248  
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  249  	fd = *(int *)key;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  250  	sock = sockfd_lookup(fd, &err);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  251  	if (sock) {
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  252  		err = sk_storage_delete(sock->sk, map);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  253  		sockfd_put(sock);
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  254  	}
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  255  
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  256  	return err;
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  257  }
> 6ac99e8f23d4b1 Martin KaFai Lau   2019-04-26  258  
> 9af362a775d83f KP Singh           2020-07-09  259  static struct bpf_local_storage_elem *
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  260  bpf_sk_storage_clone_elem(struct sock *newsk,
> 9af362a775d83f KP Singh           2020-07-09  261  			  struct bpf_local_storage_map *smap,
> 9af362a775d83f KP Singh           2020-07-09  262  			  struct bpf_local_storage_elem *selem)
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  263  {
> 9af362a775d83f KP Singh           2020-07-09  264  	struct bpf_local_storage_elem *copy_selem;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  265  
> 9af362a775d83f KP Singh           2020-07-09  266  	copy_selem = sk_selem_alloc(smap, newsk, NULL, true);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  267  	if (!copy_selem)
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  268  		return NULL;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  269  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  270  	if (map_value_has_spin_lock(&smap->map))
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  271  		copy_map_value_locked(&smap->map, SDATA(copy_selem)->data,
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  272  				      SDATA(selem)->data, true);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  273  	else
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  274  		copy_map_value(&smap->map, SDATA(copy_selem)->data,
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  275  			       SDATA(selem)->data);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  276  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  277  	return copy_selem;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  278  }
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  279  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14 @280  int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  281  {
> 9af362a775d83f KP Singh           2020-07-09  282  	struct bpf_local_storage *new_sk_storage = NULL;
> 9af362a775d83f KP Singh           2020-07-09  283  	struct bpf_local_storage *sk_storage;
> 9af362a775d83f KP Singh           2020-07-09  284  	struct bpf_local_storage_elem *selem;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  285  	int ret = 0;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  286  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  287  	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  288  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  289  	rcu_read_lock();
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  290  	sk_storage = rcu_dereference(sk->sk_bpf_storage);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  291  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  292  	if (!sk_storage || hlist_empty(&sk_storage->list))
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  293  		goto out;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  294  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  295  	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
> 9af362a775d83f KP Singh           2020-07-09  296  		struct bpf_local_storage_elem *copy_selem;
> 9af362a775d83f KP Singh           2020-07-09  297  		struct bpf_local_storage_map *smap;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  298  		struct bpf_map *map;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  299  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  300  		smap = rcu_dereference(SDATA(selem)->smap);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  301  		if (!(smap->map.map_flags & BPF_F_CLONE))
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  302  			continue;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  303  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  304  		/* Note that for lockless listeners adding new element
> 9af362a775d83f KP Singh           2020-07-09  305  		 * here can race with cleanup in bpf_local_storage_map_free.
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  306  		 * Try to grab map refcnt to make sure that it's still
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  307  		 * alive and prevent concurrent removal.
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  308  		 */
> 1e0bd5a091e5d9 Andrii Nakryiko    2019-11-17  309  		map = bpf_map_inc_not_zero(&smap->map);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  310  		if (IS_ERR(map))
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  311  			continue;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  312  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  313  		copy_selem = bpf_sk_storage_clone_elem(newsk, smap, selem);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  314  		if (!copy_selem) {
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  315  			ret = -ENOMEM;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  316  			bpf_map_put(map);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  317  			goto out;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  318  		}
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  319  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  320  		if (new_sk_storage) {
> 9af362a775d83f KP Singh           2020-07-09  321  			bpf_selem_link_map(smap, copy_selem);
> 9af362a775d83f KP Singh           2020-07-09  322  			bpf_selem_link(new_sk_storage, copy_selem);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  323  		} else {
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  324  			ret = sk_storage_alloc(newsk, smap, copy_selem);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  325  			if (ret) {
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  326  				kfree(copy_selem);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  327  				atomic_sub(smap->elem_size,
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  328  					   &newsk->sk_omem_alloc);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  329  				bpf_map_put(map);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  330  				goto out;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  331  			}
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  332  
> 9af362a775d83f KP Singh           2020-07-09  333  			new_sk_storage =
> 9af362a775d83f KP Singh           2020-07-09  334  				rcu_dereference(copy_selem->local_storage);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  335  		}
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  336  		bpf_map_put(map);
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  337  	}
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  338  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  339  out:
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  340  	rcu_read_unlock();
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  341  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  342  	/* In case of an error, don't free anything explicitly here, the
> 9af362a775d83f KP Singh           2020-07-09  343  	 * caller is responsible to call bpf_local_storage_free.
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  344  	 */
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  345  
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  346  	return ret;
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  347  }
> 8f51dfc73bf181 Stanislav Fomichev 2019-08-14  348  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


