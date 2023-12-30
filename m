Return-Path: <bpf+bounces-18755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB982086D
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 21:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0640B281724
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C8C2FE;
	Sat, 30 Dec 2023 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GvYLS2xc"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3ABC13D;
	Sat, 30 Dec 2023 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703967254; x=1704572054; i=markus.elfring@web.de;
	bh=kXNvk+63Yu+KOv3cgshkVkUjGMpZfjy8lTJZ4d+G7Uc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=GvYLS2xcMFqOVDgt4xlnovtDxtv2WddWSOgAdS/+dvOOF6ICdHIfdMBrEjlE57Mu
	 HJCdQ9ZEmyIifeESoHyStlP3GSV3ICZq6m6Kw+hzlvvlCKhUq/0XWMFCHmrQCtwGi
	 2Ap8/vG5GXheEaUjgXJEocEDQ1syWkhvpFnAWMIR3rnvsjt1pmFHrnMAol2ripcp8
	 6XhKIIpXOPtGvdl5yKHj8SoB4/fj1UDb9wKGjHLBDt3cEDTQBLg4ZXcnYVEsM7joh
	 G49qBbGnymZEf97vkCx4YuNubMlz8jovYL6C3ZkWcRnYdPgmxIU4vguYrkLfTepsv
	 3w+q4jAawarodsC7Pg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1rNW0Z3wPm-004I7J; Sat, 30
 Dec 2023 21:14:14 +0100
Message-ID: <d6294506-75a8-4a23-aa98-65b719c1d368@web.de>
Date: Sat, 30 Dec 2023 21:14:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/5] bpf: Improve exception handling in trie_update_elem()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <7011cdcc-4287-4e63-8bfa-f08710f670b1@web.de>
In-Reply-To: <7011cdcc-4287-4e63-8bfa-f08710f670b1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nOmhdZE/XojShpXxlNPMot4rOnwZaU6Vbm8qG7aVBHLczhSGTff
 oFY53srdHKkx2klXiV3k5r75jE14PrauuNDQQk0A0DEiUvC0kxHEHKGSxYULfA4cAXnr8Ca
 VS0JMBi8p5FvKtCzxRECuWcWJUgstQ+HeYbnKodFbBLbrXX5YT20nECbObq69mM/nOsBx7v
 oQaZ3vJIUG/8P657HrAEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JBDSu+CLZj8=;ozXJh2b3Fcm8mfSjPb/HtbG+Ahn
 D4GS/b+J0uR4HQTJ0BdEtU3MWAzWWTF7PTyvZ+9eHr9V1WUdECGLSPYwkX+GmuHNxnal0w5Kt
 pZ0PDZ7GQdyxMeQcdlKXY+YRdgLA0hRq6waIX14BJPiE28ET5dNQbbrA0rAhIJ8Yq8Hgplr8o
 TAZB3kAApCJjz+QP3hLmgAV+e/9T8JQHdNbAMj5R7mSrpfvT22rdADfb63F5qCuFmtgp/vjlt
 TGADwmvzR3ygwV0zsAAzD5R5ASISGlp4COEHGX0vuJAx4v34arHbM8V4FRS2CTf2k3/0uRcJX
 Rgu5nzu7DoiqETbUzr8O77gvlqECQV7IZ5asijUxrg4tEdB/t5r4fbng922H+CuT3FFTqWQ0i
 Ns9FaBc9JBQfGIf6LADdC5hJWax6w4/ZMLxK8l3WISQpQDLV1aU7NvDr3tgEnGwbUUCEWlkoS
 MYVDbKh6XogZZ4SuVu3TRRRvHdFH0Rtx6G+clJyTleKXqg1MZXHBI5pMNliRHknmn3Wn6PaTn
 LbpFBfHhvrabrL+DLRoURyEVarQYnvKZ7k40RslsZEVdTYVzkS2jTq4fZBbRzDwG8ku3gA8X4
 NhQiXJbGFCcHIAy5OH72hYYijt3Vb06uEKBqtygRAIqDnxJLXBDK5hMCYOl80Y9djLiojujis
 NUipm0hynEQozyn1enwGSFMdmUsIw3Qd4JG04v5V0GBOLjSZx2JwsHXCt0Bt+52S7bOdHkZLV
 yBx+WswKZebQGbJ4ubZmsSXJOPq73zkSyejUpYBLelPfn1o7o5K7Iy53mBrI73s+472kxWjoL
 W+FLnUmJBse3wG6eELOas91R7dwHk3V/KeyBpz3OqtYawGCxcTf0F4TPXBvHfKbAV8JAJ5qLK
 kf0SDsGg/WvYyd3TIr+7ZWK6nytMZMuh9ibVhqFvPjTAGusTqBFVnDUbx4xIYI4MrzFPKWMf+
 f+bj+Q==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 30 Dec 2023 20:28:11 +0100

The kfree() function was called in some cases by
the trie_update_elem() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus adjust jump targets.

* Reorder data processing steps at the end.

* Delete an initialisation (for the variable =E2=80=9Cnew_node=E2=80=9D)
  and a repeated pointer check which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/lpm_trie.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index b32be680da6c..6c372d831d0f 100644
=2D-- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -307,7 +307,7 @@ static long trie_update_elem(struct bpf_map *map,
 			     void *_key, void *value, u64 flags)
 {
 	struct lpm_trie *trie =3D container_of(map, struct lpm_trie, map);
-	struct lpm_trie_node *node, *im_node =3D NULL, *new_node =3D NULL;
+	struct lpm_trie_node *node, *im_node =3D NULL, *new_node;
 	struct lpm_trie_node __rcu **slot;
 	struct bpf_lpm_trie_key *key =3D _key;
 	unsigned long irq_flags;
@@ -327,13 +327,13 @@ static long trie_update_elem(struct bpf_map *map,

 	if (trie->n_entries =3D=3D trie->map.max_entries) {
 		ret =3D -ENOSPC;
-		goto out;
+		goto unlock;
 	}

 	new_node =3D lpm_trie_node_alloc(trie, value);
 	if (!new_node) {
 		ret =3D -ENOMEM;
-		goto out;
+		goto unlock;
 	}

 	trie->n_entries++;
@@ -368,7 +368,7 @@ static long trie_update_elem(struct bpf_map *map,
 	 */
 	if (!node) {
 		rcu_assign_pointer(*slot, new_node);
-		goto out;
+		goto decrement_counter;
 	}

 	/* If the slot we picked already exists, replace it with @new_node
@@ -384,7 +384,7 @@ static long trie_update_elem(struct bpf_map *map,
 		rcu_assign_pointer(*slot, new_node);
 		kfree_rcu(node, rcu);

-		goto out;
+		goto decrement_counter;
 	}

 	/* If the new node matches the prefix completely, it must be inserted
@@ -394,13 +394,13 @@ static long trie_update_elem(struct bpf_map *map,
 		next_bit =3D extract_bit(node->data, matchlen);
 		rcu_assign_pointer(new_node->child[next_bit], node);
 		rcu_assign_pointer(*slot, new_node);
-		goto out;
+		goto decrement_counter;
 	}

 	im_node =3D lpm_trie_node_alloc(trie, NULL);
 	if (!im_node) {
 		ret =3D -ENOMEM;
-		goto out;
+		goto decrement_counter;
 	}

 	im_node->prefixlen =3D matchlen;
@@ -419,15 +419,13 @@ static long trie_update_elem(struct bpf_map *map,
 	/* Finally, assign the intermediate node to the determined slot */
 	rcu_assign_pointer(*slot, im_node);

-out:
 	if (ret) {
-		if (new_node)
-			trie->n_entries--;
-
-		kfree(new_node);
 		kfree(im_node);
+decrement_counter:
+		trie->n_entries--;
+		kfree(new_node);
 	}
-
+unlock:
 	spin_unlock_irqrestore(&trie->lock, irq_flags);

 	return ret;
=2D-
2.43.0


