Return-Path: <bpf+bounces-21450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4425D84D607
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0188285DC7
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE091CD22;
	Wed,  7 Feb 2024 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmEfno17"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875A1D55E
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346082; cv=none; b=VGEtHhFZkoa7NvyrzniUJ/yArz2meGk8AT41N0As8UMo1I+cXJfca3Diom6xvTwoDsflEc6ilRtRTA74R7LIKuJA83tKEFzcE0LMuPt3QRnmAIzGxIkFvrNJHyglRYj5dyU2IcPCU1zsdx9CdE9fBnIxW7qytNpAdNg5PotSG5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346082; c=relaxed/simple;
	bh=n/eojlZF24jcFsseVU7Kn2xfCiEwsfg4yaagy4rB99g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OedzXt25YFmwQYswI24AtzMdZHDgTVFuK4YDxH7kvXCdkm8B//iKuiopPJnqb5IaXjadlwMr1kjS88m8gvfJFY00wVc80bxQDKB0o3a/lc6QJMAjNGCIPoaKLVOfKTjff498ONuDG1wD5BfmEMMvbEimxrpymlWAH0hLhJMtXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmEfno17; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so334941276.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 14:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707346080; x=1707950880; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TT0IoaPOQtUNmTubqv+zMuv9C0jmcPxoTV8uXZcZpeU=;
        b=LmEfno17Ok08bwxnBNWQqEYpqHNb07wLSt1vTcaBl5H61aod2N+8Ie9FpA+e/+cmab
         d/A5J2jioK8m9qO8EPwQSB1qdhZxv1NIf3A7FjOBxnsKUGtuMHWT8THcezFOBwOxkNbH
         zHz+M8jiMUtbNMbnURtQ0ZUZ4ZmZYulxX7Mq5E9qdavQheeZhBRHMs0Qo6p/SXdvwgXh
         oYPpvtBxx6vbbCZPdkXzJwd9pZ2SGmQaIxkMjKWAwyrRKhLTsc3tSKiTb6E2QQGoxkxP
         ubBfUnw5OnWRdIACbpQz9ljREwVXJk+yNJSYGA1YdC27csxU+AV6U9oSIBGRuHd5Imwn
         vGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707346080; x=1707950880;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TT0IoaPOQtUNmTubqv+zMuv9C0jmcPxoTV8uXZcZpeU=;
        b=niqxC1L7tzAOZjb8u8EqXbe/liXOwwvNmRYc8qlSqIrkAU6BIyA6KsyruYJJv0bLsF
         NsebXhxZS5iIFRr2V+kF33Dk73+XaZguE3W1RBXHMY9Njxw/mI+MiOj8HxCboYS57BTg
         URtzV+oMHgbhMc7rSSbkw92erag7bEGtqNStYpEJzSARpSqq/dUHeIu1/rQy7JZGMoIU
         5K/WV+31nZ/0753EwsLRIYny/mkFfS66nMYHOfj7Q6tubPvaOM+Bdg7tOg5X5GcTr0KM
         kCvRfkDdwXwV/ouoZsZ3PlSW3kmFCOV9yaDWGAaYD/BHOW05yq5k037OP4WztNOSs39B
         g3iA==
X-Gm-Message-State: AOJu0Yz0TpMrIKjtsPxdq2pJgkFhO+Lc/2kfoNjouCCPkhXLcOHa9bSt
	uTPVg1N/Czfl+dxtFhlPOP4lVhxBDuwuwiRyT/K1+f5qO8e61Cod+WqPDGx4FXtEctq1ItdIMiU
	ip0mDc8dBYb6azwAQwgkFylYcGJTcH+z+5ZlK6sdT6fI=
X-Google-Smtp-Source: AGHT+IHVPU/xw75SXaBrnjA7n/gg9rS2JU2Bro2z586NFkAfv0p1XYXcWVLBZf/MjSZfDsSkBAVvS+gOYHI8UcVE4s8=
X-Received: by 2002:a25:9747:0:b0:dc2:56e0:f5f with SMTP id
 h7-20020a259747000000b00dc256e00f5fmr637590ybo.26.1707346080049; Wed, 07 Feb
 2024 14:48:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason <jasonlkml@gmail.com>
Date: Wed, 7 Feb 2024 14:47:49 -0800
Message-ID: <CAKdkiR9HVkopmZ0JkLYMWtbG2bnzsAxXvYqHesRcoWp9Ly7zFg@mail.gmail.com>
Subject: help: trying to gather process information, tx/rx byte count ,
 ifindex for sends/receives
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The problem I'm trying to solve is associating some process
information (let's just say pid) with a socket in an fentry where it's
safe to grab pid/tgid.
It seems like inet_sendmsg is a pretty safe place to do this.

Say I want to gather information about the process initiating a
transmit as well as the interface the bit of data is going out of.
I put a fentry hook on inet_sendmsg to grab pid_tgid and then I put
another fentry hook onto ip_local_out to grab the interface.
The problem I'm seeing is that the data accessible from
fentry/ip_local_out seems unreliable. The `struct sock* sk` being
passed in often can't be associated with a `struct sock* sk` seen on
`inet_sendmsg`.

An example minimal toy program to help illustrate my dilemma.


struct {
  __uint(type, BPF_MAP_TYPE_LRU_HASH);
  __uint(max_entries, 1024);
  __type(key, struct socket*);
  __type(value, uint64_t);
} sock_to_tgid_pid SEC(".maps"); // pretty much a sk_storage, almost
interchangeable


SEC("fentry/inet_sendmsg")
int BPF_PROG(do_inet_sendmsg_enter,
             struct socket* sock,
             struct msghdr* msg,
             size_t size) {
    uint64_t pid_tgid = 0;
    pid_tgid = bpf_get_current_pid_tgid();
    bpf_map_update_elem(&sock_to_tgid_pid, sock, &pid_tgid, BPF_NOEXIST);
    return 0;
}

SEC("fentry/ip_local_out")
int BPF_PROG(do_ip_local_out, struct net* net, struct sock* sk, struct
sk_buff* skb) {
  struct socket* sock = BPF_CORE_READ(skb, sk, sk_socket);
 struct network_data* d = bpf_map_lookup_elem(&sock_to_tgid_pid,
sock); <==== This will sometimes fail
 if (d == NULL){
bpf_printk("Failed socket lookup");
}
}

The test case would be that I run ping several times and in some
situations the map lookup will be fine and other situations the map
lookup will fail.


My initial thought is that putting fentry/fexit hooks deep within the
networking stack might not be the best idea.. Maybe there is a lot of
nuance I'm not familiar with?

I then started looking at tc hooks, thinking that this is a well lit
path. Unfortunately for tc hooks a struct __sk_buff* is passed in and
there doesn't seem to be a way to get at the socket that owns the
data.

So my questions are:

1.) Does anyone see anything obviously wrong with my fentry approach?
2.) Is there a way to get at a socket cookie, sk_storage or a reliable
struct socket* from within a tc-ebpf?
3.) Am I asking on the wrong lkml and should instead cross-post this
to a more network oriented lkml?

Thanks in advance

