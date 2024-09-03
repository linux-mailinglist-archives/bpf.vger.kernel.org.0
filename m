Return-Path: <bpf+bounces-38843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B413D96ABDA
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 00:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D211E1C24353
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 22:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0824F1DB539;
	Tue,  3 Sep 2024 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d2JmdJmS"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011075.outbound.protection.outlook.com [52.103.32.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FDE1DA601;
	Tue,  3 Sep 2024 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401329; cv=fail; b=WUKArGMDOIE+0ayH7s2kylXZwftLd6QpLZpZ+aXjnPS+BwZB1CcLU2sanIyX4rO9iCdpa7mefY7KqYeXbTp867/DM4UKQFlINdGId9zlkg8nne249tW3yZ5Im4X7pxeg8/iwwhaKznsx1RVJqehV4lDdG9ulZ7xD9xogveQlC1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401329; c=relaxed/simple;
	bh=vh/yqItwJkDMVvkX1lubkicsB5hZvWDaRxYgpMNQc7M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=isIvWLf7x355OCS8IFBdolDKzh/syjQjh1XTXrrUx0MxEKhEaEy8jrWz0Px8CxzykPyAZG5pIIqKIK4oVXPtCqMSoUSQfWQ4hrp87U+JUT0SOzEA4c4RbwmteQobtHpJ5U9y5cxqU74xK9nvzg7VHdggzvbsU4ZKoWbO3CI2uDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d2JmdJmS; arc=fail smtp.client-ip=52.103.32.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARLXixBPf2jLYwUXhHbKzyUAqE+KlDC6UHWk6AyddAdHWKQJZAag86M7gky0FVfY4xO51FupKpZa0hP/J2yt9WqfIG7BOXbhwjLCwqN5Nrlkt17/JCmAcVXFoSFpR5cVtcg3HO+zBgN3zaLnI1FjHU+wr8R+oMAAEYE9mMPqWGBfr6CXasjKFmoaV0DTL7ozx8il8YxqNSjUKeljIdgqKy0tiORedfBfnUkudMcE/opAtzgjxYbpwYmevE0ZdIx84be/pemGl1EjhtO3hpBPFxV8vnFbo8ge2JWqnYMk5a60q80+lux9/kpYXY8YzLTROwNLbDaYMcFqBjMUoJeIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KzkCQAn6eSwVTstLnV1Y5vvz99ok1FCkT/1uHXqfe4=;
 b=cpiRf4OGbgTHRgaRWIyrUmJTOXIbhqEo2RzPeseUGluP79UyjPleVA9c6y2pQ3ne1hMt4OuXXQdqr5X5x+0z1lmErO2Y+XhzWwebii7xPtvcaZY6lHicBDovtJ/jkSRx0A/hFGxmxEqNRYz/0Dpuk5C1USCfWO922c4yuKMO/3FoGjUpwJHRMmMRvr2fL+aQm9/T5GJTLh+jQOrgfwkdGYC8yKCCep+TPnUQdi0wmUFnr5LIxgTDPfoU+7YGa8p898rpeD9zu7E1HV1UUzFYb6MwiEICRG3yA7J40emLJ9M4SkVz2j07pQRhTNU0dpCn4hOtRDu9fXMK0b5gBCvGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KzkCQAn6eSwVTstLnV1Y5vvz99ok1FCkT/1uHXqfe4=;
 b=d2JmdJmSd/Cf9ls/Wd4wc3QJU2MKyD6JWZgR/UT3/vyiJt6fIO9Hhm9RbqicLIaPUZTR9JCgm+UWD4tDdeAN24Ph7Fb64WNBdKPWNsNHTfjNItgzlfXuEQkIVxTrCm95EHGBSjo0u4oWTD2d0FoaMMOcD9V+7dacfGQ49NBd99i5VlTrbdkU+Y3a65hUA31gmSaO4tyR9QIy1CMCcbHeJbOw45gbuadj4tmIkTFyezE3grWmjG0ieiGwEVO/oKQk9yeL6lDX+o93/XkgJiX6sSeFLzCl7hNDErMHTJVvybHDXkF9r6vQ9EdxQJdDA0b+HV2j/uj1l0FjMcC5NBVOFw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by VI1PR03MB6335.eurprd03.prod.outlook.com (2603:10a6:800:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 22:08:42 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 22:08:42 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 1/2] bpf: Add open-coded style iterator kfuncs for bpf dynamic pointers
Date: Tue,  3 Sep 2024 23:07:25 +0100
Message-ID:
 <AM6PR03MB5848C2304B17658423B4B81D99932@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [rlT0C9vVUPcMddM7DvR99F4UsvYaBaTs]
X-ClientProxiedBy: LO4P123CA0342.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::23) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240903220725.82539-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|VI1PR03MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 59cd1662-e5f2-49af-2fb8-08dccc64f89f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|15080799006|5072599009|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	oGJiY+qkuLudyQ1z0ByRtgTaqxDttoigvWCvcn2jRiMfIquM5t76Nm4l86W/YPtPYtKce5jdD6s1bkpwPfGk3+DhFbOdoqaTlRFhGJw3ODaUf7zecSeaLyudk7EzKZrI5UiLN5gy9VccvJaK9OkQRhMnZZ7LS0+WQ2OdXYx9dQcYzDmU6/46m58ZmR/S69Hwi7FuEO6LOFhGJq8RWVaM7wyj54RJljF6Di4jfgFXjfrniHQDI5tp1JzxmX4Isg4IDm915arpVmsk0eQYR9ue2Nt7YVNyr6JPgbFKsiHeo7RZNRWHSZDzJBjtEbowIGxwnFwA4wmwKyjVDlDMGKg0Vkr346yss5tA0IkQ2Ofo8H1r70XFeFe4iWvKT8qxLJCOwFXlmKHR9P3wZlwxeZNqKW7Osl2pasHt7eEeSaefxgrXw01+BvNQlMpDUvHn5rPBPi519LdHsMJYY+wJM2MulOPe3LoqCdd+n8lAdf/9wO2pLfjye/msAFCeJ9AjYMGTFwVf3SPc4YRIKjGveL7SifbBCVvUWtEeqDfhaSNAroydwjhve4tpSkEtsd1bfGZmj7zfjq+BOnRGT/kxwjZEBg5w68tg5wLgbcqmKvuEQpqYE3sK0AmFMCFploILszTQ6PBv4YmWEJq6Atx2+jLHBkWSwwwaXUG+2/XSCNeZFjQi9MIOH7hL4cYjjx+xdBDGKbcKDQQgZGOfbmoDGRwB6z7vyTw98+9tgYqlLjtJ3pCMfmBVpyNgFcr6CnwEOwrvGSTKvUR5zbm5t2ROjP/TupuTahGvFfLBaqWRDYJLJO81b81+dCgAfNHizutGSotA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1X7Kqn5qaJYjpRVAQBSQN9XP6O9WejCVl/xUFQLSaDOW25VuDm0OOj8r8vD0?=
 =?us-ascii?Q?pVLgwU1IYl1oq3PfE8sPdQDIpGYaBI/3v0y+ShHfIC2iHqdZMEtn+Z00odqn?=
 =?us-ascii?Q?ahZLAb4ZCJ0Ey+VAmcfdaCXgKBW7mY5hnb31bKby6cnN4Y8e2gJU6hEFtmDg?=
 =?us-ascii?Q?gn/xRn8rEDTketSWXTfIX9pwGAkmSNXxzSih4iHs2oE2x31K9Rb4PWZ2Zh7r?=
 =?us-ascii?Q?MYECI49lBzPW+K+UhV0zE6qK9ipKuOmxOArTVy1L8KuxN2ROzKKG5C7bgaJF?=
 =?us-ascii?Q?NDAhhJfn/Mi4G9CDO0P/6UdWksHroEHXK3pFD8I4IlArreKm9DHhVUKWr2zl?=
 =?us-ascii?Q?1pdhH/fdxGVf3xbVcNiLAXE9d93By8UZx0TJA6Rd++ZByNooAViVtfOaPpli?=
 =?us-ascii?Q?T63DlK0eSarOqlDs3xnDX2b0w7WMLnm4II8hHmgalq2p8maHJArmrcs/scjP?=
 =?us-ascii?Q?nGaN7u5iYEWNuUE70znZxXjmshq3rihvJSFEpGzaVQwqJqMDw7j1c9HYKsYC?=
 =?us-ascii?Q?YfC/ZKVFkle+ystoGfRWwWAhUNms67CWc/CAX/YYxsfK8+Sgz0U7FW45azX4?=
 =?us-ascii?Q?6hJhnSPQOGdr9/iq0+8p/QdW7wUPWGv7vWWLf4ghmXKRziGjaMp3TGZeBYwV?=
 =?us-ascii?Q?a+RC1zTZJ7XXTHv16TQUgWIMkd0PcpX8pxKNQ/Ui4SngyEndLb7Sfhv4iUOJ?=
 =?us-ascii?Q?PxstO0+ww2TR4S3a7rCWuq+tV7aerkj230FqLNKidsSDeLBsTMzTrKZtgJEk?=
 =?us-ascii?Q?idfkPbAZAEtxkRE0iLg2sWfTHirSt5CHyRNBCYyj8oJNnG/dhl4boOzB/QkL?=
 =?us-ascii?Q?KmzWSxqPxVf6FLTMsroQFSHmjwKyJovicfLDdO324vhbVz8q/szkwwgL0uM5?=
 =?us-ascii?Q?lsbwRqqzkoNL5s+xH8oX4YsMa9yHUvM5wx6aeTvlptdinW0M5y6pl8DiEAPQ?=
 =?us-ascii?Q?gF1jyvqZ9PKhGwxZmkL+rFwrefMAPK+IBywL5J2FOTd8pSzQUFChuMvaaLHt?=
 =?us-ascii?Q?S4PG0jQXK5ZYb1uEM7tUrH6mBW97Al3ERNnTCz3KvbMe7GjHvAgsdUCQbElp?=
 =?us-ascii?Q?3sVP/UtGzqM0tlrsN2Qr4YFGt+9VkhyVNFNxzh7Bz6CJQhi4lpJMQqPNXBig?=
 =?us-ascii?Q?7VwnlcSwvy+tAE/O5Uk1voHGD7M7S7HiQpXfOc7l3fWBeMlotNW8AHID74C6?=
 =?us-ascii?Q?smS4PRAwih51Fn3KBKKpOWuBKAC6/AlPWP2IWTFaYRs/LjDp7MIQPfaZ08y3?=
 =?us-ascii?Q?PDzfWBMAlv1HcslY8VGc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cd1662-e5f2-49af-2fb8-08dccc64f89f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 22:08:42.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6335

This patch adds open coded style bpf dynamic pointer iterator kfuncs
bpf_iter_dynptr_{new,next,destroy} for iterating over all data in the
memory region referenced by dynamic pointer.

The idea of bpf dynamic pointer iterator comes from skb data iterator
[0], we need a way to get all the data in skb. Adding iterator for bpf
dynamic pointer is a more general choice than adding separate skb data
iterator.

Each iteration (next) copies the data to the specified buffer and
updates the offset, with the pointer to the length of the read data
(errno if errors occurred) as the return value. Note that the offset
in iterator does not affect the offset in dynamic pointer.

The bpf dynamic pointer iterator has a getter kfunc,
bpf_iter_dynptr_get_last_offset, which is used to get the offset
of the last iteration.

The bpf dynamic pointer iterator has a setter kfunc,
bpf_iter_dynptr_set_buffer, which is used to set the buffer and buffer
size to be used when copying data in the iteration.

[0]: https://lore.kernel.org/bpf/AM6PR03MB5848DE102F47F592D8B479E999A52@AM6PR03MB5848.eurprd03.prod.outlook.com/

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/helpers.c | 110 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3956be5d6440..1f7204b54ba9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2729,6 +2729,111 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
 	return 0;
 }
 
+struct bpf_iter_dynptr {
+	__u64 __opaque[4];
+} __aligned(8);
+
+struct bpf_iter_dynptr_kern {
+	struct bpf_dynptr_kern *dynptr;
+	void *buffer;
+	u32 buffer_len;
+	u32 offset;
+	int read_len;
+} __aligned(8);
+
+__bpf_kfunc int bpf_iter_dynptr_new(struct bpf_iter_dynptr *it, struct bpf_dynptr *p,
+				    u32 offset, void *buffer, u32 buffer__szk)
+{
+	struct bpf_iter_dynptr_kern *kit = (void *)it;
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_dynptr_kern) > sizeof(struct bpf_iter_dynptr));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_dynptr_kern) !=
+		     __alignof__(struct bpf_iter_dynptr));
+
+	if (!ptr->data)
+		return -EINVAL;
+
+	if (!buffer || buffer__szk <= 0)
+		return -EINVAL;
+
+	if (offset >= __bpf_dynptr_size(ptr))
+		return -E2BIG;
+
+	kit->dynptr = ptr;
+	kit->buffer = buffer;
+	kit->buffer_len = buffer__szk;
+	kit->offset = offset;
+	kit->read_len = 0;
+
+	return 0;
+}
+
+__bpf_kfunc int *bpf_iter_dynptr_next(struct bpf_iter_dynptr *it)
+{
+	struct bpf_iter_dynptr_kern *kit = (void *)it;
+	int read_len, ret;
+	u32 size;
+
+	if (!kit->dynptr)
+		return NULL;
+
+	if (!kit->dynptr->data)
+		return NULL;
+
+	if (unlikely(kit->read_len < 0))
+		return NULL;
+
+	size = __bpf_dynptr_size(kit->dynptr);
+
+	if (kit->offset >= size)
+		return NULL;
+
+	read_len = (kit->offset + kit->buffer_len > size) ? size - kit->offset : kit->buffer_len;
+
+	ret = bpf_dynptr_read((u64)kit->buffer, read_len, (u64)kit->dynptr, kit->offset, 0);
+	if (unlikely(ret != 0)) {
+		/* if errors occur in bpf_dynptr_read, the errno is returned via read_len
+		 * and NULL is returned in the next iteration to exit the iteration loop.
+		 */
+		kit->read_len = ret;
+		goto out;
+	}
+
+	kit->read_len = read_len;
+	kit->offset += read_len;
+out:
+	return &kit->read_len;
+}
+
+__bpf_kfunc int bpf_iter_dynptr_set_buffer(struct bpf_iter_dynptr *it__iter,
+					   void *buffer, u32 buffer__szk)
+{
+	struct bpf_iter_dynptr_kern *kit = (void *)it__iter;
+
+	if (!buffer || buffer__szk <= 0)
+		return -EINVAL;
+
+	kit->buffer = buffer;
+	kit->buffer_len = buffer__szk;
+
+	return 0;
+}
+
+__bpf_kfunc u32 bpf_iter_dynptr_get_last_offset(struct bpf_iter_dynptr *it__iter)
+{
+	struct bpf_iter_dynptr_kern *kit = (void *)it__iter;
+
+	if (!kit->dynptr)
+		return 0;
+
+	return kit->offset - kit->read_len;
+}
+
+__bpf_kfunc void bpf_iter_dynptr_destroy(struct bpf_iter_dynptr *it)
+{
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -3080,6 +3185,11 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_iter_dynptr_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_dynptr_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_dynptr_get_last_offset)
+BTF_ID_FLAGS(func, bpf_iter_dynptr_set_buffer)
+BTF_ID_FLAGS(func, bpf_iter_dynptr_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_ID_FLAGS(func, bpf_wq_init)
 BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
-- 
2.39.2


