Return-Path: <bpf+bounces-7166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AC3772682
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163BD1C20B41
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A53210960;
	Mon,  7 Aug 2023 13:48:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54B10958;
	Mon,  7 Aug 2023 13:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48459C433C8;
	Mon,  7 Aug 2023 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691416132;
	bh=wuj6SUxGrJEiEaxycf3zFEQQB3mPHY/qFqe5ETkwJiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FihCNa5SWcVtfcpLwVD5yaeGTxf3a2H0Wxykjq3H5CxSG+3RTbpwp0bMSRt1Jz2fA
	 0zAJTqQpEO6ELWTg6mi5btIMhf3zP6gJbvqL3jAHd4tFmWrLA9e/nv9RK9Z0Jwvdqz
	 E88Pff9W49oRe+thFv+Lp0Xt/IlsiXwv3tEtcNVzKpNUQZAsImbFVQLZsP+W3v9s41
	 AgZy0oZPqzFcJVRKYC/wEwcGG+MALGU/3TOBamHq896+uv/KNk80zW35n/45grsfYN
	 YdIp4P0zoCIfRTkZdoolRpyirrVJ+Q2tAHVxIknan7BYHex3oDfCeSytEj1p+ftCK3
	 nGQekgO61edkg==
Date: Mon, 7 Aug 2023 15:48:46 +0200
From: Simon Horman <horms@kernel.org>
To: Matthew Cover <werekraken@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Matthew Cover <matthew.cover@stackpath.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next] Add bnxt_netlink to facilitate representor pair
 configurations.
Message-ID: <ZND2PrIX7y5jN0Zg@vergenet.net>
References: <20230804212954.98868-1-matthew.cover@stackpath.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804212954.98868-1-matthew.cover@stackpath.com>

On Fri, Aug 04, 2023 at 02:29:54PM -0700, Matthew Cover wrote:

...

Hi Matthew,

> +static int bnxt_parse_attrs(struct nlattr **a, struct bnxt **bp,
> +			    struct net_device **dev)
> +{
> +	pid_t pid;
> +	struct net *ns = NULL;
> +	const char *drivername;
> +
> +	if (!a[BNXT_ATTR_PID]) {
> +		netdev_err(*dev, "No process ID specified\n");
> +		goto err_inval;
> +	}
> +	pid = nla_get_u32(a[BNXT_ATTR_PID]);
> +	ns = get_net_ns_by_pid(pid);
> +	if (IS_ERR(ns)) {
> +		netdev_err(*dev, "Invalid net namespace for pid %d (err: %ld)\n",
> +			pid, PTR_ERR(ns));
> +		goto err_inval;
> +	}
> +
> +	if (!a[BNXT_ATTR_IF_INDEX]) {
> +		netdev_err(*dev, "No interface index specified\n");
> +		goto err_inval;
> +	}
> +	*dev = dev_get_by_index(ns, nla_get_u32(a[BNXT_ATTR_IF_INDEX]));
> +
> +	put_net(ns);
> +	ns = NULL;
> +	if (!*dev) {
> +		netdev_err(*dev, "Invalid network interface index %d (err: %ld)\n",
> +		       nla_get_u32(a[BNXT_ATTR_IF_INDEX]), PTR_ERR(ns));
> +		goto err_inval;
> +	}
> +	if (!(*dev)->dev.parent || !(*dev)->dev.parent->driver ||
> +	    !(*dev)->dev.parent->driver->name) {
> +		netdev_err(*dev, "Unable to get driver name for device %s\n",
> +		       (*dev)->name);
> +		goto err_inval;
> +	}
> +	drivername = (*dev)->dev.parent->driver->name;
> +	if (strcmp(drivername, DRV_MODULE_NAME)) {
> +		netdev_err(*dev, "Device %s (%s) is not a %s device!\n",
> +		       (*dev)->name, drivername, DRV_MODULE_NAME);
> +		goto err_inval;
> +	}
> +	*bp = netdev_priv(*dev);
> +	if (!*bp) {

We only get here if *bp is NULL.
But on the following line *bp is dereferenced.

Perhaps this should be netdev_warn(*dev, ...)

Flagged by Smatch.

> +		netdev_warn((*bp)->dev, "No private data\n");
> +		goto err_inval;
> +	}
> +
> +	return 0;
> +
> +err_inval:
> +	if (ns && !IS_ERR(ns))
> +		put_net(ns);
> +	return -EINVAL;
> +}
> +
> +/* handler */
> +static int bnxt_netlink_hwrm(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nlattr **a = info->attrs;
> +	struct net_device *dev = NULL;
> +	struct sk_buff *reply = NULL;
> +	struct input *req, *nl_req;
> +	struct bnxt *bp = NULL;
> +	struct output *resp;
> +	int len, rc;
> +	void *hdr;
> +
> +	rc = bnxt_parse_attrs(a, &bp, &dev);
> +	if (rc)
> +		goto err_rc;
> +
> +	if (!bp) {
> +		rc = -EINVAL;
> +		goto err_rc;
> +	}
> +
> +	if (!bp->hwrm_dma_pool) {
> +		netdev_warn(bp->dev, "HWRM interface not currently available on %s\n",
> +		       dev->name);
> +		rc = -EINVAL;
> +		goto err_rc;
> +	}
> +
> +	if (!a[BNXT_ATTR_REQUEST]) {
> +		netdev_warn(bp->dev, "No request specified\n");
> +		rc = -EINVAL;
> +		goto err_rc;
> +	}
> +	len = nla_len(a[BNXT_ATTR_REQUEST]);
> +	nl_req = nla_data(a[BNXT_ATTR_REQUEST]);
> +
> +	reply = genlmsg_new(PAGE_SIZE, GFP_KERNEL);
> +	if (!reply) {
> +		netdev_warn(bp->dev, "Error: genlmsg_new failed\n");
> +		rc = -ENOMEM;
> +		goto err_rc;
> +	}
> +
> +	rc = hwrm_req_init(bp, req, nl_req->req_type);

hwrm_req_init() expects a variable of type u16  as it's type parameter.
But the tupe of nl_req->req_type is __le32.

As flagged by Sparse.


> +	if (rc)
> +		goto err_rc;
> +
> +	rc = hwrm_req_replace(bp, req, nl_req, len);
> +	if (rc)
> +		goto err_rc;
> +
> +	resp = hwrm_req_hold(bp, req);
> +	rc = hwrm_req_send_silent(bp, req);
> +	if (rc) {
> +		/*
> +		 * Indicate success for the hwrm transport, while letting
> +		 * the hwrm error be passed back to the netlink caller in
> +		 * the response message.  Caller is responsible for handling
> +		 * any errors.
> +		 *
> +		 * no kernel warnings are logged in this case.
> +		 */
> +		rc = 0;
> +	}
> +	hdr = genlmsg_put_reply(reply, info, &bnxt_netlink_family, 0,
> +				BNXT_CMD_HWRM);
> +	if (nla_put(reply, BNXT_ATTR_RESPONSE, resp->resp_len, resp)) {

Likewise, the type of resp->resp_len is __le16, but an int is expected.

> +		netdev_warn(bp->dev, "No space for response attribte\n");
> +		hwrm_req_drop(bp, req);
> +		rc = -ENOMEM;
> +		goto err_rc;
> +	}
> +	genlmsg_end(reply, hdr);
> +	hwrm_req_drop(bp, req);
> +
> +	dev_put(dev);
> +	dev = NULL;
> +
> +	return genlmsg_reply(reply, info);
> +
> +err_rc:
> +	if (reply && !IS_ERR(reply))
> +		kfree_skb(reply);
> +	if (dev && !IS_ERR(dev))
> +		dev_put(dev);
> +
> +	if (bp)
> +		netdev_warn(bp->dev, "returning with error code %d\n", rc);
> +
> +	return rc;
> +}

...

