Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B95570CF9
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 23:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiGKVsU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 17:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiGKVsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 17:48:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F2382443
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:17 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BLWf9r028436
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PjhTR0NdHUghZjZ7cWUS4LAULJYW+PLGtuDjSa2NSOY=;
 b=d3rOvQgrLfCD9GogYzCJ+evoMOj9/MZ1ra5qo38oYvjDClpoRpfqfr2ceUH4o22XWhvN
 Lq0G2HvTi1D8OERA3aA61XoEV0hs9xD9DTswrDLb3Xb/vAftP5KAxbbkQKERgFdy3fJi
 C8AvmEWE97m7IhkN0rZeh4s7OjcM1tNdFQI= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h79043syk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 14:48:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WISi7YAGgi3XsMczleb8FETNhg4Hl1CjappqHI8ESGODHHmINPizO9xoN4tzGF7moLNYmAWdgL4ljgUGWVhIgDSmi61i1h85j1xgrWpVurekO3xVYSHZ92XFbzeYZw7+65TYIDanyKCah5TAGUjTuTvIny65nKRSsfAmNRmK39DzZwIqCad7L6e/MheRsSJDhVUbQPWfqeTcPesk8/vPyjpP7bVYAsSbmcl+ZY5v7tEwV5JYyvIu5senEBOzgD0KYJZLf+NcJmvf3G6GCSX4lvOLJZVtKfW5yRTc/6rPieE+RE3QpHFhpOFbs0nRDmk36D5VBIghooSg6zpkWkyzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjhTR0NdHUghZjZ7cWUS4LAULJYW+PLGtuDjSa2NSOY=;
 b=P5esYG2x0Yxk9yv8bzQtE41NCq0shBRtoJj5DAyjyqPqWKrweaeqNjSd7zQVebCNA7Y0tc8zpnDWehk4mfbVpLOswkQP3BQqcom6vkiozH/4klUWU628xdN8jPtRd1x6JXEo3wWiFQSohiKQM/pXdIeYuED0bHlv200dkY1FhTtlr7/W0JISHL1Ue00AEi8aq9z0NYgiihyhU+BO14nJ/sO/rot6Q3KSViDd3RdU4VRnlqmTA0cZ+RBauWN/r0ansCf7G7o+j9P2mkw6hKWa1SgkB0G/1afkIkc7oW6cQZK9m+mVsMpJO9Xy3TWQxaMvr9ifjJMeThONudo6eeswOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB2522.namprd15.prod.outlook.com (2603:10b6:5:1a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 21:48:13 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e%9]) with mapi id 15.20.5395.020; Mon, 11 Jul 2022
 21:48:13 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH RFC bpf-next 1/3] bpf: allow maps to hold bpf_delayed_work
 fields
Thread-Topic: [PATCH RFC bpf-next 1/3] bpf: allow maps to hold
 bpf_delayed_work fields
Thread-Index: AQHYlW/rlnricuCpGUCEoXjJ7Q5oaA==
Date:   Mon, 11 Jul 2022 21:48:13 +0000
Message-ID: <37859ca03aaaba23f60288de044a3a10d52a79b4.1657576063.git.delyank@fb.com>
References: <cover.1657576063.git.delyank@fb.com>
In-Reply-To: <cover.1657576063.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87be4845-ad38-4fda-2392-08da63870e29
x-ms-traffictypediagnostic: DM6PR15MB2522:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9tHNUfUad+11PBNWSpZQNzvt8lXJSgnn22mErionW3ig21aYQPGvNF/0f1mvaGLyWZC9lzwJru2P8jsQDMgZhPEasdCe4o0rEBqfAbOPz1wsCIF7ncR5ady39bHTg1UwCbeV2T99rTUcqEG38AzAhNa8LMJ2TqGG4pQeFw6OO9b5LYxE7YeN+17c3W0fMWNf9ccW3fUOMohOmxV9GHLoRx4bBqQAcJaTWfjsZ8uACDr7ofR5dIJM7QAMBWipeSjZBdykpgy4VR3q4TIxIhOJqmgngonLrjCN39xb1LblTsFImdOulIQHmLVNqMTCuUCwzPhqAWaGyy0GtpxOo5mitHfZLnJBKqHR+U7ta7p39ABnaXH0yKdbVcIan4E+JsEfaGXz3RCYGjyYhv1clY1U9MBut7o9+IGcfWrvti0uJ1gJKRyvN/L2bpXD+bKOLQycfDN+VtUZzk8wQ83EEyKugT2Ot+TQ3s/E2bysdkE5L74LcgFoLmPQlaMEkefjwiR3xvCPiEfe6YqKt0SjFw0Mau4rvm7b6MKJ5UhK1SMWAQ5CmDQLf2RWGGs+/8YwtpaPdymO71lq+kwoPE6uLzqRr2E8E2tFWsX/rhyFS5yltgq0OQQqUdHSjgCS9Fu6QAmDUhjM7uOuh2kzlJSjHr2Wr1SxzGzv9pNladMQRWow/zD0M2xwxuQ4a0FCf17FB6n0GWhpCv1cZJBpQqHTtw/GwJgtE/lFoYpuR9axOXPyOmpypeWqOT/U1tb6Twcr+aTaEVL+IC7J/93ZZW0R45ubsVRrYw4i+LindX/G9YUy/fgat3pBsVf7G0i6iD+bLivL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(38100700002)(186003)(122000001)(83380400001)(71200400001)(2616005)(36756003)(64756008)(8676002)(66476007)(316002)(110136005)(76116006)(66946007)(66446008)(91956017)(2906002)(6506007)(478600001)(41300700001)(6512007)(6486002)(38070700005)(8936002)(5660300002)(66556008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4RI+VQyfh0je5eoFiEEs9H/nxesXGU1HQHVnTK9saVuYO2NEN4SAW6OjLn?=
 =?iso-8859-1?Q?+nYMEGXNPjn59iHjnCSS5OlK7FtBJ6PPRQ+9OFQ8FM1rRBQt64WCDKZGw7?=
 =?iso-8859-1?Q?JdGyVYU3/vDG+JAXETtJlLFnJxrKs9n88VfnsOO7PgIV6uYNBMezkvN8ty?=
 =?iso-8859-1?Q?ooVdnIT3LhWcjHhHlpy63WGhiXZSk/o1yN70oeaPC3T4V3zE6bzHhQQHuJ?=
 =?iso-8859-1?Q?x0yD3Jkm7zADjynJcBHPqMUDX7Nnbz8U+77ECv1XI9nAtkUmd/WhqrWetb?=
 =?iso-8859-1?Q?NkQV1jK1JdSHhinyP7lcbuRbLAJ30l9ZoQZgD+iYosZrngDN++SvtoJ0PN?=
 =?iso-8859-1?Q?SeEG5yLBxKwD7pJZBxKjXReMvwOFqvq22kHyN1sPmmd50i8Tx2ua/v49z5?=
 =?iso-8859-1?Q?wFLIrZsZnTmBooFn18g24m6+j6WyazonEB7tilzyGGmTSFFyLVAWAj6t38?=
 =?iso-8859-1?Q?O1rTtuQ+QLz4RScFYWbMBPzUZzLnP6IMPk9QHiaUeIfu+DcazMIz/8zxDa?=
 =?iso-8859-1?Q?Nl2iXnip+sY/YInu8Cu31WutXoiInPrZCOkH1R5P83LsmEEIxA6aCew7Xg?=
 =?iso-8859-1?Q?ybF9j+abwSL/vGqNRwDUOGyzuJ+zP+PGzUTaCAJqAgbsT+lvU6vfkhREyC?=
 =?iso-8859-1?Q?ZnTFYioS8o6nZ9Dnr4RZXLehmoVtAz9TD0woqSShssdvHxjdWtBKu+Ko+w?=
 =?iso-8859-1?Q?20cWMFHQCzRTdQqbapAX4nbyEb2MWNSrhaJnx6q8SyHq8Xd9zFzxmUAbV1?=
 =?iso-8859-1?Q?0hnNlKn2ZA20/UHg+Id6ilXJpptN4Zh8o/QBwJwFNIOxUgmu/o4lcTP6sm?=
 =?iso-8859-1?Q?FWg2gzPuK2Hb5tL8YR9dQKVTM6Ib1gBFU4sYbE5IOFZ5BznBQHC/xncsCB?=
 =?iso-8859-1?Q?29AmlxBF0x555R1WZ97/PAvpsMRRU99cRYOKmEVjxsl3E0IhHTtFfJnksT?=
 =?iso-8859-1?Q?FCXc3HJCeS+lIaNsj9aBZ8jHaYD6T0D0LYYEgEbgj84DxCmyjc+VDvPfRX?=
 =?iso-8859-1?Q?Rsq3NNxw96yAkv4bJe/hHSK9h4R+QjDjiSzg3NW2yOOfI3J1BpkPMW2wcm?=
 =?iso-8859-1?Q?fIoyOJBHwFNeKQCRiLAb2D5LvU1XNzM0XNYFpxcBm4swi7JWXfEwbgBpz7?=
 =?iso-8859-1?Q?PtJPlWxdMYisoG6H1Mbfecr4CbhzfrDuCaR2bQAyWxBvIYdQ/kIpIcb8IQ?=
 =?iso-8859-1?Q?L15VyH831ORG+bxjbreMYTBuS7jpZ+E9cghEglgw+4rJxhPB76CoehZyiq?=
 =?iso-8859-1?Q?Yo3Vlblfv3rh/nQAw1VRYRk/nH2bEo6Mv2LG+f3Z/HpYx1oWFzBkbFiL/h?=
 =?iso-8859-1?Q?7n8ZT691ThdruAYpiLsgZcxhKaSqV974gB2P+xualOEdNdYyOEvr1Pxdpg?=
 =?iso-8859-1?Q?dqfS7CfZooEDk1qByfctK99dMYnZy0NRnDXFkRMa1Rtvqehw9zFnWMgz4U?=
 =?iso-8859-1?Q?mbXxUlbxJV2tnIhK+A9iJWwpGW1i07giI8h4mbmVUxOm4xYtfX6MEOYuhL?=
 =?iso-8859-1?Q?R+K+fqfcG3pbLRWKUqBsyYEJ9YVjL5xa1hxv7h97yp7AyhZkhiykLOIMO2?=
 =?iso-8859-1?Q?41Xfrll1qkvuYZUu9gp+H+M4rS+STAte86fY816cEzh7GbE2kt/kF6wcV0?=
 =?iso-8859-1?Q?zy9xRqCNLl8hC4EWGLR6XseHLcdbj2Y2bdz5npoAgCZEU+nT5ZkxIjiA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87be4845-ad38-4fda-2392-08da63870e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 21:48:13.5345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XjTa58iBFAB4u9QlB/aVTTIhOc9RIGwlHePUkuSuYgXp00XxSxohQYtf9nUMQtG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2522
X-Proofpoint-ORIG-GUID: 8AX_I2ZistJpvsoIIGLjiEHt-fyyy_IU
X-Proofpoint-GUID: 8AX_I2ZistJpvsoIIGLjiEHt-fyyy_IU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_25,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to bpf_timer, bpf_delayed_work represents a callback that will
be executed at a later time, in a different execution context.

Its treatment in maps is practically the same as timers (to a degree
that perhaps calls for refactoring), except releasing the work does not
need to release any resources - we will wait for pending executions in
the program destruction path.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 include/linux/bpf.h            |  9 ++++++++-
 include/linux/btf.h            |  1 +
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/btf.c               | 21 +++++++++++++++++++++
 kernel/bpf/syscall.c           | 24 ++++++++++++++++++++++--
 kernel/bpf/verifier.c          |  9 +++++++++
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 7 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0edd7d2c0064..ad9d2cfb0411 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -164,7 +164,8 @@ enum {
 	BPF_MAP_VALUE_OFF_MAX =3D 8,
 	BPF_MAP_OFF_ARR_MAX   =3D BPF_MAP_VALUE_OFF_MAX +
 				1 + /* for bpf_spin_lock */
-				1,  /* for bpf_timer */
+				1 + /* for bpf_timer */
+				1,  /* for bpf_delayed_work */
 };
=20
 enum bpf_kptr_type {
@@ -212,6 +213,7 @@ struct bpf_map {
 	int spin_lock_off; /* >=3D0 valid offset, <0 error */
 	struct bpf_map_value_off *kptr_off_tab;
 	int timer_off; /* >=3D0 valid offset, <0 error */
+	int delayed_work_off; /* >=3D0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
 	u32 btf_key_type_id;
@@ -256,6 +258,11 @@ static inline bool map_value_has_timer(const struct bp=
f_map *map)
 	return map->timer_off >=3D 0;
 }
=20
+static inline bool map_value_has_delayed_work(const struct bpf_map *map)
+{
+	return map->delayed_work_off >=3D 0;
+}
+
 static inline bool map_value_has_kptrs(const struct bpf_map *map)
 {
 	return !IS_ERR_OR_NULL(map->kptr_off_tab);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1bfed7fa0428..2b8f473a6aa0 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -132,6 +132,7 @@ bool btf_member_is_reg_int(const struct btf *btf, const=
 struct btf_type *s,
 			   u32 expected_offset, u32 expected_size);
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
+int btf_find_delayed_work(const struct btf *btf, const struct btf_type *t)=
;
 struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 					  const struct btf_type *t);
 bool btf_type_is_void(const struct btf_type *t);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e81362891596..d68fc4f472f1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6691,6 +6691,14 @@ struct bpf_dynptr {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+struct bpf_delayed_work {
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f08037c31dd7..e4ab52cc25fe 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3196,6 +3196,7 @@ enum btf_field_type {
 	BTF_FIELD_SPIN_LOCK,
 	BTF_FIELD_TIMER,
 	BTF_FIELD_KPTR,
+	BTF_FIELD_DELAYED_WORK,
 };
=20
 enum {
@@ -3283,6 +3284,7 @@ static int btf_find_struct_field(const struct btf *bt=
f, const struct btf_type *t
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
+		case BTF_FIELD_DELAYED_WORK:
 			ret =3D btf_find_struct(btf, member_type, off, sz,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3333,6 +3335,7 @@ static int btf_find_datasec_var(const struct btf *btf=
, const struct btf_type *t,
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
+		case BTF_FIELD_DELAYED_WORK:
 			ret =3D btf_find_struct(btf, var_type, off, sz,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3375,6 +3378,11 @@ static int btf_find_field(const struct btf *btf, con=
st struct btf_type *t,
 		sz =3D sizeof(struct bpf_timer);
 		align =3D __alignof__(struct bpf_timer);
 		break;
+	case BTF_FIELD_DELAYED_WORK:
+		name =3D "bpf_delayed_work";
+		sz =3D sizeof(struct bpf_delayed_work);
+		align =3D __alignof__(struct bpf_delayed_work);
+		break;
 	case BTF_FIELD_KPTR:
 		name =3D NULL;
 		sz =3D sizeof(u64);
@@ -3421,6 +3429,19 @@ int btf_find_timer(const struct btf *btf, const stru=
ct btf_type *t)
 	return info.off;
 }
=20
+int btf_find_delayed_work(const struct btf *btf, const struct btf_type *t)
+{
+	struct btf_field_info info;
+	int ret;
+
+	ret =3D btf_find_field(btf, t, BTF_FIELD_DELAYED_WORK, &info, 1);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -ENOENT;
+	return info.off;
+}
+
 struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 					  const struct btf_type *t)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7d5af5b99f0d..041972305344 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -914,10 +914,11 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
 	bool has_spin_lock =3D map_value_has_spin_lock(map);
 	bool has_timer =3D map_value_has_timer(map);
 	bool has_kptrs =3D map_value_has_kptrs(map);
+	bool has_delayed_work =3D map_value_has_delayed_work(map);
 	struct bpf_map_off_arr *off_arr;
 	u32 i;
=20
-	if (!has_spin_lock && !has_timer && !has_kptrs) {
+	if (!has_spin_lock && !has_timer && !has_kptrs && !has_delayed_work) {
 		map->off_arr =3D NULL;
 		return 0;
 	}
@@ -953,6 +954,13 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
 		}
 		off_arr->cnt +=3D tab->nr_off;
 	}
+	if (has_delayed_work) {
+		i =3D off_arr->cnt;
+
+		off_arr->field_off[i] =3D map->delayed_work_off;
+		off_arr->field_sz[i] =3D sizeof(struct bpf_delayed_work);
+		off_arr->cnt++;
+	}
=20
 	if (off_arr->cnt =3D=3D 1)
 		return 0;
@@ -1014,6 +1022,16 @@ static int map_check_btf(struct bpf_map *map, const =
struct btf *btf,
 			return -EOPNOTSUPP;
 	}
=20
+	map->delayed_work_off =3D btf_find_delayed_work(btf, value_type);
+	if (map_value_has_delayed_work(map)) {
+		if (map->map_flags & BPF_F_RDONLY_PROG)
+			return -EACCES;
+		if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
+		    map->map_type !=3D BPF_MAP_TYPE_LRU_HASH &&
+		    map->map_type !=3D BPF_MAP_TYPE_ARRAY)
+			return -EOPNOTSUPP;
+	}
+
 	map->kptr_off_tab =3D btf_parse_kptrs(btf, value_type);
 	if (map_value_has_kptrs(map)) {
 		if (!bpf_capable()) {
@@ -1095,6 +1113,7 @@ static int map_create(union bpf_attr *attr)
=20
 	map->spin_lock_off =3D -EINVAL;
 	map->timer_off =3D -EINVAL;
+	map->delayed_work_off =3D -EINVAL;
 	if (attr->btf_key_type_id || attr->btf_value_type_id ||
 	    /* Even the map's value is a kernel's struct,
 	     * the bpf_prog.o must have BTF to begin with
@@ -1863,7 +1882,8 @@ static int map_freeze(const union bpf_attr *attr)
 		return PTR_ERR(map);
=20
 	if (map->map_type =3D=3D BPF_MAP_TYPE_STRUCT_OPS ||
-	    map_value_has_timer(map) || map_value_has_kptrs(map)) {
+	    map_value_has_timer(map) || map_value_has_kptrs(map) ||
+	    map_value_has_delayed_work(map)) {
 		fdput(f);
 		return -ENOTSUPP;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2859901ffbe3..9fd311b7a1ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3817,6 +3817,15 @@ static int check_map_access(struct bpf_verifier_env =
*env, u32 regno,
 			return -EACCES;
 		}
 	}
+	if (map_value_has_delayed_work(map) && src =3D=3D ACCESS_DIRECT) {
+		u32 t =3D map->delayed_work_off;
+
+		if (reg->smin_value + off < t + sizeof(struct bpf_delayed_work) &&
+		     t < reg->umax_value + off + size) {
+			verbose(env, "bpf_delayed_work cannot be accessed directly by load/stor=
e regno=3D%d off=3D%d\n", regno, off);
+			return -EACCES;
+		}
+	}
 	if (map_value_has_kptrs(map)) {
 		struct bpf_map_value_off *tab =3D map->kptr_off_tab;
 		int i;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index e81362891596..d68fc4f472f1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6691,6 +6691,14 @@ struct bpf_dynptr {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+struct bpf_delayed_work {
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
--=20
2.36.1
