Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046AF63D34D
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 11:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiK3K3v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiK3K3u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 05:29:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB131FAC
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 02:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669804128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gIxDAUeZ+xj1woLu0SbHPPVv3F8ks63V7wyqar7wbYY=;
        b=MQvdabRgTC0Rp2oqa+TIgxitBvw1RUKdRiroG9FVdxX5pseY8/1wCS+tC8rPsm1Ba2e63D
        MLUUUcmudzfiFgVGRCiCkG1Zo7AWeWJCYKXocPnA+lnk8TUCNtqz0juRNiWJ4gAMfIYCG9
        6HeCaies0rGQPMRW3Loo1lM++Ig10B4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-g33Eag3JNkyMEVFV3ug5ww-1; Wed, 30 Nov 2022 05:28:47 -0500
X-MC-Unique: g33Eag3JNkyMEVFV3ug5ww-1
Received: by mail-wm1-f72.google.com with SMTP id m17-20020a05600c3b1100b003cf9cc47da5so9184573wms.9
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 02:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIxDAUeZ+xj1woLu0SbHPPVv3F8ks63V7wyqar7wbYY=;
        b=3gPZfg/eYeAONEcNF32WMC0333nXdIiIqkoA565yEVnrmjitQaYB7TpLbjaiFV54V7
         EgZStSLaxXNaPXEb6iVOCo4bE6VWLx1O7IqCkaSkEHzliQmhaXPWUkrDTKsbESVImJ3g
         9pUx+LDfEiL9fPhUNXke5gZguTB/PFdSAqdgpVmhUuqyb0WdqldpvlGxsjJniLxjzBOD
         0ZRQ1uD1Kybh/tvi/aQ61mqEA9DjeooKrJ2eNFpb6jEskNnAsFUKV2D0H5ImPl1cIw90
         k0+bDao9iZGqqPCJDDkaOzjulvolByNHGFEckC3Fs52b0JKdc/R5V0+WvOJBqyYqIgrL
         5yjA==
X-Gm-Message-State: ANoB5pnwZ4NvB3OrrCk1pOJtAguz/etIfxdxodvrm/XDMDGsebFtJnMR
        ofnXJQ/wEONWuKavaLrAjwPqVP2hV2GQIfdcMc+BNdstdsyd93vLuRO43X/jisPzRYT4056KZus
        ulxjUzp5KVQwLEQc0a/2yeF9whz69e6HVy1fPron6VXKdl8eKGTAhNWGlF24SZi0=
X-Received: by 2002:a05:600c:4f10:b0:3b4:ff86:25af with SMTP id l16-20020a05600c4f1000b003b4ff8625afmr29592718wmq.68.1669804125687;
        Wed, 30 Nov 2022 02:28:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6EhS76gnzR0pznsS6jNvnCangHl8COLYKCf/GE6A3D/jv24Rd5lPruQY3zhiRzEMm+EengcA==
X-Received: by 2002:a05:600c:4f10:b0:3b4:ff86:25af with SMTP id l16-20020a05600c4f1000b003b4ff8625afmr29592693wmq.68.1669804125211;
        Wed, 30 Nov 2022 02:28:45 -0800 (PST)
Received: from localhost.localdomain ([78.16.131.111])
        by smtp.gmail.com with ESMTPSA id m18-20020adfe952000000b002421888a011sm1131391wrn.69.2022.11.30.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:28:44 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        john.fastabend@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v1 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Date:   Wed, 30 Nov 2022 10:28:42 +0000
Message-Id: <20221130102842.12788-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Add documentation for BPF_MAP_TYPE_SOCK[MAP|HASH]
including kernel versions introduced, usage
and examples.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 Documentation/bpf/map_sockmap.rst | 439 ++++++++++++++++++++++++++++++
 1 file changed, 439 insertions(+)
 create mode 100644 Documentation/bpf/map_sockmap.rst

diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
new file mode 100644
index 000000000000..8824a67b24e8
--- /dev/null
+++ b/Documentation/bpf/map_sockmap.rst
@@ -0,0 +1,439 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright Red Hat
+
+==============================================
+BPF_MAP_TYPE_SOCKMAP and BPF_MAP_TYPE_SOCKHASH
+==============================================
+
+.. note::
+   - ``BPF_MAP_TYPE_SOCKMAP`` was introduced in kernel version 4.14
+   - ``BPF_MAP_TYPE_SOCKHASH`` was introduced in kernel version 4.18
+
+``BPF_MAP_TYPE_SOCKMAP`` is backed by an array that uses an integer key as the
+index to lookup a reference to a sock struct. The map values are sockets.
+Similarly, ``BPF_MAP_TYPE_SOCKHASH`` is a hash backed BPF map that holds
+references to sockets.
+
+When these maps are created BPF programs are attached to them. The list of
+allowed programs is shown below:
+
+.. code-block:: c
+
+	struct sk_psock_progs {
+		struct bpf_prog *msg_parser;
+		struct bpf_prog *stream_parser;
+		struct bpf_prog *stream_verdict;
+		struct bpf_prog	*skb_verdict;
+	};
+
+.. note::
+    Users are not allowed to attach ``stream_verdict`` and ``skb_verdict``
+    programs to the same map.
+
+The parser programs determine how much data needs to be queued to come to a
+verdict. The verdict programs return a verdict ``__SK_DROP``, ``__SK_PASS``, or
+``__SK_REDIRECT``.
+
+The attach types for the map programs are:
+
+- ``msg_parser`` program - ``BPF_SK_MSG_VERDICT``.
+- ``stream_parser`` program - ``BPF_SK_SKB_STREAM_PARSER``.
+- ``stream_verdict`` program - ``BPF_SK_SKB_STREAM_VERDICT``.
+- ``skb_verdict`` program - ``BPF_SK_SKB_VERDICT``.
+
+These maps can be used to redirect skbs between sockets or to apply policy at
+the socket level based on the result of a verdict program with the help of the
+BPF helpers ``bpf_sk_redirect_map()``, ``bpf_sk_redirect_hash()``,
+``bpf_msg_redirect_map()`` and ``bpf_msg_redirect_hash()``.
+
+When a socket is inserted into one of these maps, its socket callbacks are
+replaced and a ``struct sk_psock`` is attached to it. Additionally, this
+``sk_psock`` inherits the programs that are attached to the map.
+
+.. note::
+	For more details of the socket callbacks that get replaced please see:
+
+	- TCP BPF functions: ``net/ipv4/tcp_bpf.c``
+	- UDP BPF functions: ``net/ipv4/udp_bpf.c``
+
+There are additional helpers available to use with the parser and verdict
+programs: ``bpf_msg_apply_bytes()`` and ``bpf_msg_cork_bytes()``. With
+``bpf_msg_apply_bytes()`` BPF programs can tell the infrastructure how many
+bytes the given verdict should apply to. The helper ``bpf_msg_cork_bytes()``
+handles a different case where a BPF program can not reach a verdict on a msg
+until it receives more bytes AND the program doesn't want to forward the packet
+until it is known to be good.
+
+Finally, the helpers ``bpf_msg_pull_data()`` and ``bpf_msg_push_data()`` are
+available to ``BPF_PROG_TYPE_SK_MSG`` BPF programs to pull in data and set the
+start and end pointer to given values or to add metadata to the ``struct
+sk_msg_buff *msg``.
+
+Usage
+=====
+Kernel BPF
+----------
+bpf_msg_redirect_map()
+^^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+	long bpf_msg_redirect_map(struct sk_msg_buff *msg, struct bpf_map *map, u32 key, u64 flags)
+
+This helper is used in programs implementing policies at the socket level. If
+the message ``msg`` is allowed to pass (i.e. if the verdict BPF program
+returns ``SK_PASS``), redirect it to the socket referenced by ``map`` (of type
+``BPF_MAP_TYPE_SOCKMAP``) at index ``key``. Both ingress and egress interfaces
+can be used for redirection. The ``BPF_F_INGRESS`` value in ``flags`` is used
+to select the ingress path otherwise the egress path is selected. This is the
+only flag supported for now.
+
+Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
+
+bpf_sk_redirect_map()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key u64 flags)
+
+Redirect the packet to the socket referenced by ``map``(of type
+``BPF_MAP_TYPE_SOCKMAP``) at index ``key``. Both ingress and egress interfaces
+can be used for redirection. The ``BPF_F_INGRESS`` value in ``flags`` is used
+to select the ingress path otherwise the egress path is selected. This is the
+only flag supported for now.
+
+Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
+
+bpf_map_lookup_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+socket entries of type ``struct sock *`` can be retrieved using the
+``bpf_map_lookup_elem()`` helper.
+
+bpf_sock_map_update()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_sock_map_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
+
+Add an entry to, or update a ``map`` referencing sockets. The ``skops`` is used
+as a new value for the entry associated to ``key``. The ``flags`` argument can
+be one of the following:
+
+- ``BPF_ANY``: Create a new element or update an existing element.
+- ``BPF_NOEXIST``: Create a new element only if it did not exist.
+- ``BPF_EXIST``: Update an existing element.
+
+If the ``map`` has BPF programs (parser and verdict), those will be inherited
+by the socket being added. If the socket is already attached to BPF programs,
+this results in an error.
+
+Returns 0 on success, or a negative error in case of failure.
+
+bpf_sock_hash_update()
+^^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_sock_hash_update(struct bpf_sock_ops *skops, struct bpf_map *map, void *key, u64 flags)
+
+Add an entry to, or update a sockhash ``map`` referencing sockets. The ``skops``
+is used as a new value for the entry associated to ``key``.
+
+The ``flags`` argument can be one of the following:
+
+- ``BPF_ANY``: Create a new element or update an existing element.
+- ``BPF_NOEXIST``: Create a new element only if it did not exist.
+- ``BPF_EXIST``: Update an existing element.
+
+If the ``map`` has BPF programs (parser and verdict), those will be inherited
+by the socket being added. If the socket is already attached to BPF programs,
+this results in an error.
+
+Returns 0 on success, or a negative error in case of failure.
+
+bpf_msg_redirect_hash()
+^^^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_msg_redirect_hash(struct sk_msg_buff *msg, struct bpf_map *map, void *key, u64 flags)
+
+This helper is used in programs implementing policies at the socket level. If
+the message ``msg`` is allowed to pass (i.e. if the verdict BPF program returns
+``SK_PASS``), redirect it to the socket referenced by ``map`` (of type
+``BPF_MAP_TYPE_SOCKHASH``) using hash ``key``. Both ingress and egress
+interfaces can be used for redirection. The ``BPF_F_INGRESS`` value in
+``flags`` is used to select the ingress path otherwise the egress path is
+selected. This is the only flag supported for now.
+
+Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
+
+bpf_sk_redirect_hash()
+^^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_sk_redirect_hash(struct sk_buff *skb, struct bpf_map *map, void *key, u64 flags)
+
+This helper is used in programs implementing policies at the skb socket level.
+If the sk_buff *skb* is allowed to pass (i.e. if the verdict BPF program
+returns ``SK_PASS``), redirect it to the socket referenced by *map* (of type
+``BPF_MAP_TYPE_SOCKHASH``) using hash ``key``. Both ingress and egress
+interfaces can be used for redirection. The ``BPF_F_INGRESS`` value in
+``flags`` is used to select the ingress path otherwise the egress path is
+selected. This is the only flag supported for now.
+
+Returns ``SK_PASS`` on success, or ``SK_DROP`` on error.
+
+bpf_msg_apply_bytes()
+^^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_msg_apply_bytes(struct sk_msg_buff *msg, u32 bytes)
+
+For socket policies, apply the verdict of the BPF program to the next (number
+of ``bytes``) of message ``msg``. For example, this helper can be used in the
+following cases:
+
+- A single ``sendmsg()`` or ``sendfile()`` system call contains multiple
+  logical messages that the BPF program is supposed to read and for which it
+  should apply a verdict.
+- A BPF program only cares to read the first ``bytes`` of a ``msg``. If the
+  message has a large payload, then setting up and calling the BPF program
+  repeatedly for all bytes, even though the verdict is already known, would
+  create unnecessary overhead.
+
+Returns 0
+
+bpf_msg_cork_bytes()
+^^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_msg_cork_bytes(struct sk_msg_buff *msg, u32 bytes)
+
+For socket policies, prevent the execution of the verdict BPF program for
+message ``msg`` until the number of ``bytes`` have been accumulated.
+
+This can be used when one needs a specific number of bytes before a verdict can
+be assigned, even if the data spans multiple ``sendmsg()`` or ``sendfile()``
+calls.
+
+Returns 0
+
+bpf_msg_pull_data()
+^^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_msg_pull_data(struct sk_msg_buff *msg, u32 start, u32 end, u64 flags)
+
+For socket policies, pull in non-linear data from user space for ``msg`` and set
+pointers ``msg->data`` and ``msg->data_end`` to ``start`` and ``end`` bytes
+offsets into ``msg``, respectively.
+
+If a program of type ``BPF_PROG_TYPE_SK_MSG`` is run on a ``msg`` it can only
+parse data that the (``data``, ``data_end``) pointers have already consumed.
+For ``sendmsg()`` hooks this is likely the first scatterlist element. But for
+calls relying on the ``sendpage`` handler (e.g. ``sendfile()``) this will be
+the range (**0**, **0**) because the data is shared with user space and by
+default the objective is to avoid allowing user space to modify data while (or
+after) BPF verdict is being decided. This helper can be used to pull in data
+and to set the start and end pointer to given values. Data will be copied if
+necessary (i.e. if data was not linear and if start and end pointers do not
+point to the same chunk).
+
+A call to this helper is susceptible to change the underlying packet buffer.
+Therefore, at load time, all checks on pointers previously done by the verifier
+are invalidated and must be performed again, if the helper is used in
+combination with direct packet access.
+
+All values for ``flags`` are reserved for future usage, and must be left at
+zero.
+
+Returns 0 on success, or a negative error in case of failure.
+
+User space
+----------
+
+bpf_map_update_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+	int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags)
+
+sockmap entries can be added or updated using the ``bpf_map_update_elem()``
+helper. The ``key`` parameter is the index value of the sockmap array. And the
+``value`` parameter is the FD value of that socket.
+
+Under the hood, the sockmap update function uses the socket FD value to
+retrieve the associated socket and its attached psock.
+
+The flags argument can be one of the following:
+
+- BPF_ANY: Create a new element or update an existing element.
+- BPF_NOEXIST: Create a new element only if it did not exist.
+- BPF_EXIST: Update an existing element.
+
+bpf_map_lookup_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    int bpf_map_lookup_elem(int fd, const void *key, void *value)
+
+Sockmap entries can be retrieved using the ``bpf_map_lookup_elem()``
+helper.
+
+bpf_map_delete_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    int bpf_map_delete_elem(int fd, const void *key)
+
+Sockmap entries can be deleted using the ``bpf_map_delete_elem()``
+helper. This helper will return 0 on success, or negative error in case of
+failure.
+
+Examples
+========
+
+Kernel BPF
+----------
+Several examples of the use of sockmap APIs can be found in:
+
+- `tools/testing/selftests/bpf/progs/test_sockmap_kern.h`_
+- `tools/testing/selftests/bpf/progs/sockmap_parse_prog.c`_
+- `tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c`_
+- `tools/testing/selftests/bpf/progs/test_sockmap_listen.c`_
+- `tools/testing/selftests/bpf/progs/test_sockmap_update.c`_
+
+The following code snippet shows how to declare a sockmap.
+
+.. code-block:: c
+
+	struct {
+		__uint(type, BPF_MAP_TYPE_SOCKMAP);
+		__uint(max_entries, 1);
+		__type(key, __u32);
+		__type(value, __u64);
+	} sock_map_rx SEC(".maps");
+
+The following code snippet shows a sample parser program.
+
+.. code-block:: c
+
+	SEC("sk_skb/stream_parser")
+	int bpf_prog_parser(struct __sk_buff *skb)
+	{
+		return skb->len;
+	}
+
+The following code snippet shows a simple verdict program that interacts with a
+sockmap to redirect traffic to another socket based on the local port.
+
+.. code-block:: c
+
+	SEC("sk_skb/stream_verdict")
+	int bpf_prog_verdict(struct __sk_buff *skb)
+	{
+		__u32 lport = skb->local_port;
+		__u32 idx = 0;
+
+		if (lport == 10000)
+			return bpf_sk_redirect_map(skb, &sock_map_rx, idx, 0);
+
+		return SK_PASS;
+	}
+
+The following code snippet shows how to declare a sockhash map.
+
+.. code-block:: c
+
+	struct socket_key {
+		__u32 src_ip;
+		__u32 dst_ip;
+		__u32 src_port;
+		__u32 dst_port;
+	};
+
+	struct {
+		__uint(type, BPF_MAP_TYPE_SOCKHASH);
+		__uint(max_entries, 1);
+		__type(key, struct socket_key);
+		__type(value, __u64);
+	} sock_hash_rx SEC(".maps");
+
+The following code snippet shows a simple verdict program that interacts with a
+sockhash to redirect traffic to another socket based on a hash of some of the
+skb parameters.
+
+.. code-block:: c
+
+	static inline
+	void extract_socket_key(struct __sk_buff *skb, struct socket_key *key)
+	{
+		key->src_ip = skb->remote_ip4;
+		key->dst_ip = skb->local_ip4;
+		key->src_port = skb->remote_port >> 16;
+		key->dst_port = (bpf_htonl(skb->local_port)) >> 16;
+	}
+
+	SEC("sk_skb/stream_verdict")
+	int bpf_prog_verdict(struct __sk_buff *skb)
+	{
+		struct socket_key key;
+
+		extract_socket_key(skb, &key);
+
+		return bpf_sk_redirect_hash(skb, &sock_hash_rx, &key, 0);
+	}
+
+User space
+----------
+Several examples of the use of sockmap APIs can be found in:
+
+- `tools/testing/selftests/bpf/prog_tests/sockmap_basic.c`_
+- `tools/testing/selftests/bpf/test_sockmap.c`_
+- `tools/testing/selftests/bpf/test_maps.c`_
+
+The following code snippet shows how to create a sockmap and add a socket
+entry:
+
+.. code-block:: c
+
+	/* Create a map and populate it with one socket*/
+	static void create_sample_sockmap(int s)
+	{
+		const int index = 0;
+		int map, err;
+
+		map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int), sizeof(int), 1, NULL);
+		if (map < 0) {
+			fprintf(stderr, "Failed to create sockmap: %s\n", strerror(errno));
+			goto out;
+		}
+
+		err = bpf_map_update_elem(map, &index, &s, BPF_NOEXIST);
+		if (err) {
+			fprintf(stderr, "Failed to update sockmap: %s\n", strerror(errno));
+			goto out;
+		}
+
+	out:
+		close(map);
+	}
+
+References
+===========
+
+- https://github.com/jrfastab/linux-kernel-xdp/commit/c89fd73cb9d2d7f3c716c3e00836f07b1aeb261f
+- https://lwn.net/Articles/731133/
+- http://vger.kernel.org/lpc_net2018_talks/ktls_bpf_paper.pdf
+- https://lwn.net/Articles/748628/
+
+.. _`tools/testing/selftests/bpf/progs/test_sockmap_kern.h`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+.. _`tools/testing/selftests/bpf/progs/sockmap_parse_prog.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/sockmap_parse_prog.c
+.. _`tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
+.. _`tools/testing/selftests/bpf/prog_tests/sockmap_basic.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+.. _`tools/testing/selftests/bpf/test_sockmap.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/test_sockmap.c
+.. _`tools/testing/selftests/bpf/test_maps.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/test_maps.c
+.. _`tools/testing/selftests/bpf/progs/test_sockmap_listen.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
+.. _`tools/testing/selftests/bpf/progs/test_sockmap_update.c`: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/progs/test_sockmap_update.c
-- 
2.34.1

