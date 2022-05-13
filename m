Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B08525955
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376292AbiEMBWp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352238AbiEMBWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:22:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27685E172
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:39 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CNMQNS013161
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Fj5V1hMQud1OFWz0v9Zn1Fa+JEsc+UlO2SR6jp7ufYw=;
 b=nQ5vXAEkpL4tX6DrXDSpTrpMC41ZDLC5AciWTjhqCeIJ7jH0dhn4/exekw1LSeh43Qxr
 JTFWTbmqu0zvuEnwaGV+pC6STOE6RpG4o8Qi6VkwU8b7veUk+HKikGg0dpAwPzK+XMU0
 qBhDIxduW+e8y8QNHyfh5Rv7kZQ2ttbEg44= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g055hyj3c-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEf5QEI0+tnXfAr6VHbWAbThMnT/V7jNe+XpLIwudFo9SQdoq6eu3E4H5oz/kw42OtfgP5RxqEeKZaQsKTqht0F604JmjNGk6FEugZkjjNOc+FZbVD9m3NIcS3FzPkhj4NCWMzf05IbETbKXYY4W+3RqbEWnmlgaggpnr2n6x/8ZKCLiL/aKYJxWOQGbSb7A0YNux2yUmZiRSVPTjm7rAQ7iN7XWZSlaOcchOvRH5RhxS+ZvjraEtc58naX0PK/HVdDbqdocUC+TK0UfAbvdSHo7cicgr6fOnFKgvbR7mOeH+7tiOebvr1+qG90rXIk5tPhyMSJGYReqrsfrZKwE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj5V1hMQud1OFWz0v9Zn1Fa+JEsc+UlO2SR6jp7ufYw=;
 b=SKb1YSQ9Ym9kw6rjIkQG6TnwHjysOQ9lEllGwIwx1eA0oTKEcLgCUaCJ6YH62uL0Dc4iCTk29i+tb4KtQdhfxij0oCBFDjSOEdTYgffZa/Znk7mAyFVOXFxuBYDUWuIKbxdw+WM21C0WxsTv8ExFVCybBUg+Ym7Pg10Lhr6KKYRtae+KnYpp2ROtnzj3znxUWCDDXeCbclOHGqgr1eC3gzGU9Dlly2cgoyxHIkZcbiImPLg0q+BCJgJmo1pTCKeMUje94F1lDS9bXMl1w3WE9/tz0IXI/wNXryCUTq+Pp9AixVodLfLINW1CqYZz5dF4MjIkHpHUOZByHG1wh1+TBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by PH0PR15MB4575.namprd15.prod.outlook.com (2603:10b6:510:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 01:22:36 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 01:22:36 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: move bpf_prog to bpf.h
Thread-Topic: [PATCH bpf-next v2 1/5] bpf: move bpf_prog to bpf.h
Thread-Index: AQHYXnmyxbkRSEhIiESP57CBJDNDWK0XeGWAgAKlPYA=
Date:   Fri, 13 May 2022 01:22:36 +0000
Message-ID: <d71a2eca2aed7256c7fcf30cad9e05d17e594018.camel@fb.com>
References: <cover.1651532419.git.delyank@fb.com>
         <616c50d61de26eacd49fbb641d3122a85ca478fc.1651532419.git.delyank@fb.com>
         <20220510030433.msgh5boc6xrh6pdv@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220510030433.msgh5boc6xrh6pdv@MBP-98dd607d3435.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7673d941-76d5-440e-ba57-08da347f1075
x-ms-traffictypediagnostic: PH0PR15MB4575:EE_
x-microsoft-antispam-prvs: <PH0PR15MB45757E351752BDCDED1FC962C1CA9@PH0PR15MB4575.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndH5WLzi64+HrtLLFH0YfnKgyzCkFIf+6SwnuB4qLD9RhBQVudbTJe4qLHIMQb4tCWcryrwnkm+w/BAYK0OCIs7Zh/3pGHOsgRnWHIXwFLGjktMHkyLltyN78DSgTQsm0inQHZRvtVpw7M87cDShmp6KH0e7bV/qnkr18uBy5GYWxu+agMc4C3gfg6w9FVh7MyNzN0rJ+L57WeU1sF44fTPuK0ufY8+mGzEvPXlGPcEEmDR68XdOAudEks+7AmINooF/D6dHu5cXrEEnZY36gVEQL6shnchTXaVCM4rJ+jjavrvYKnHK4eBdav+1iHe4fJ139JigTb1p+eS5AiAfvCc31GSoaVCExCexAW9QdFjBVcnjw/2YrOWfkT2UDW30GZdxiFDr8aFjyltxnak/lUz1KH6sOZYUJPSfTRHn7VwYDSiFEFOlUjH20bUu4g7/CYKoDj2K90QxkwFCQZZjo4KSnG5GW0h4kzH6wuuwHMc0oY8iMIqYcxiv+9LZgK49g16pAU95bevcy52XVuWrMWLEgkh6XwB46SoQhTmTGW+eSTfHTCRlZs60DbAO0sINjcc2cCXFok444bq1XGlrxG1WDLIQlPDOEpayEk1k1A4dl88x8OiU0G/o7I/N+R7ZK3u/5XAMdJVb1rF7zVW1JQHyf9ogGDnQMn2H1M+nokCmujCsRBpenXYIvHNhZFQ2JocdJdQH9jywtSYB8Y7LZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(122000001)(186003)(66446008)(2906002)(36756003)(54906003)(6916009)(316002)(38070700005)(76116006)(66946007)(91956017)(38100700002)(66556008)(83380400001)(8936002)(4326008)(64756008)(8676002)(6486002)(5660300002)(508600001)(71200400001)(6512007)(6506007)(86362001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmZCQUVkZlovamg1cWxRei9CcXRYMU9nWCttYS96NHVYeHJOZjR4TzFDbnAy?=
 =?utf-8?B?WXlvclNTOWw2NGJOek9hcWFHTTcvQkR2VWErcXdzMGRocW5OYWhzOUdBUjlh?=
 =?utf-8?B?R0tmS08rUkhpSHVxTno0TTFTTElYR2hNamFOZDNHQy9sWXoxRk9YVUh3d1oz?=
 =?utf-8?B?RlZDY1ZMb3NEUzV4Y2xNbGdnNzNROTJQMVdCcjRPcFNydmQxM0loNTZJN2p2?=
 =?utf-8?B?VDBTdFhDMEMxWFFsQ01kQTY5ZXNZcUFFejNVcHllTVU1TklGVThDWFF6T3F3?=
 =?utf-8?B?YUZJOEYwWU5oL3ViQUlDQjlZVW02aUhTWjk0b3dDemdEOUZTWDhzaHJaYlVr?=
 =?utf-8?B?NDRKbElhRXArSE5DS3dQNnY3cWJyWjh5MlVsdlNtRzlWeW5oRDk3M21TaHVl?=
 =?utf-8?B?T1NxNVpvOUxEd0NUQmxMaC9xenZOYnFoTFdySjhOaWJna3RBU1ZLeTE3QzR0?=
 =?utf-8?B?QzlyUjRYWE01WlNieUR6SVljeUQ2bGU5QkdaTjl4cGxvWHhFb0oxc042YXdM?=
 =?utf-8?B?ZXFBVmVlOFBmR3pvdlhrUzZ2YXJEd20zZFBSY1FJNDNvSlJBWitYSDU5QWsw?=
 =?utf-8?B?ejQ4SklHRjhkeXpBNmlqRm5ITzJkbm1SUmROMG9WSndKTVh0NlBpalViWERE?=
 =?utf-8?B?SDE5K2FmaDJtTUhmRm9DUjZaNlU2K0ZSQlFGUFZES24wMTFKb2haT0xMMG1i?=
 =?utf-8?B?enBlRnllemp4Y09tbFh5VWJJVjlQSEhJZmZuZlJyTk5nZVJYT2tqWkNiaGk4?=
 =?utf-8?B?QzhpQ3ZtanFXWVpHNzdBMTNrekV2ZTM0OERoUkk1VlhXdW5JY1NFL1dOcklR?=
 =?utf-8?B?ZnBJZnRaY2c2OTRaaEZ4TnlTZGEwSHVCRnU3Y0RoOHJ5S1M4aytoeFhBYTNh?=
 =?utf-8?B?amNGcHprVGs5WmsvZ0UrS0hIYUE5Zkp2a3NoUVVPRmJYOXArYXJZNkh5ZGh5?=
 =?utf-8?B?Sk1GcVdYRHBjVlhCTTdMS3N3ckFSeWJNMXVHbjY5NHV1RFpDREU1bDR0UWI2?=
 =?utf-8?B?Q0wwSXdQalk5T2tLTmo4WmxJQzc0WkNrN2tubE1uTFFXeUhXeWJuczlpQ0tG?=
 =?utf-8?B?eEdoNGlsR3JGS3BPYmpEc21Id01WUmxYcy9KenVJN3ppTDJiZUJIOHVFbW1m?=
 =?utf-8?B?MVpoRXIxRTQ2RklSZnBBMnpSU2I0Q0hqeUwyajd6cEVtUXhaRXZIa3AzSkpr?=
 =?utf-8?B?WXExQ29IU04rSk9TcWRaZXdTL3UvT2EreFJPZHZMb2t3emM5cmFLRDJFSGRi?=
 =?utf-8?B?Nk5uMmg2QjdJMnFod3hiUE5ONHNTUUJxeUFIc0grRURldFB4KytSeVNBU3Jl?=
 =?utf-8?B?UFMycXR5KzZNU244ZjJwYkk1YzdVeGdPc2plQVdWNjQwNW1WdHRKNlgzUTcv?=
 =?utf-8?B?ZlpNdGF6dHhpeEhGWWEwQ1R4OFNHbS82cG9BaXVsb3ZEenhNSjcvcDk3dHJx?=
 =?utf-8?B?ZHFYYkxVbWVNZ2VLOTBNdW01a3FIazM2NFhkY2hIaFZiSTE4MGduQjQyZ1JU?=
 =?utf-8?B?TGV3TVd0NllBai82a3kzRlBzQmFpUVg4YUFpbUtQVUhQT3dWYXE2dTNJUnY3?=
 =?utf-8?B?YitFdm9IM1VRT0pzNzFxa01CK05aQmdoMUpIUlQrYTBVampmck80TDlYMzBE?=
 =?utf-8?B?U3NGTlVhVE9pUndWaE1RV3Q3NE5rU0tCT1RzbFloWldsZ0dwMlFNUWRFVnc1?=
 =?utf-8?B?c25oZFNCeW5HaUI3UnA4NHM1MFhRSnFzczh5ZzlUbk0renJWTjA0WDN1UzRB?=
 =?utf-8?B?eXU0YWUvdngwWUZCRnBoNHZCRktIYmxKK1RsNk1NTGRmK0toRE5zb0RtZHYw?=
 =?utf-8?B?S3dYdzFDeWkwKzI5c3FmWkZMaUpwUEViMXR5VGxwR3hXbmliUk9RTlMwOWx2?=
 =?utf-8?B?NW84N1M1NEJwbys2ZGQ3TFlVOXRSVk5nU3VOMm1udTErQno2ZnpxV3hLbzZM?=
 =?utf-8?B?cGJJYUhtdTVrK2ZSak1MN1BITVRRUTdRcmhXREozVUR5Wk5QbkRuRkhCbXBX?=
 =?utf-8?B?VHpWdHlwZkJsVmlPYXpiQy8yUHR0YzhETDNYd1Y5RW8zYlpTcFE1UzMxdWp1?=
 =?utf-8?B?Z0U4UmhUaVB6cy84Q1JzRHFnU0x3TTRSU0tkUTNNNi9aQ3hiQmIyNmxQN3NX?=
 =?utf-8?B?L1U0WHRxT0UwWGhNcDJOMGpuQ1pycGk3ZHE0b0doNGtqS0RVTjA1VHhPUXFh?=
 =?utf-8?B?VGlDdWwxMVR4S1p6cGs0VWx3dWEvWVdRSktzeENuZkg2aWRZcnpwbkMvYS82?=
 =?utf-8?B?Zkw4Q3Fubm8yem9hQmljQ2diMWFMaDBPZVlUaE5CRGNXQjZYQld5ZkltL1Zw?=
 =?utf-8?B?c2xiL3VWMm5DWTRsdzhNMGwrSjZKWVZEZWY5dG9hdTFSa0d3QTl6TW1aLys2?=
 =?utf-8?Q?zrRFOPdZVcTCZwrXC2q6k4vo1/2L0FYeB9CeZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BA76F96B256F443A1401F83095D6068@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7673d941-76d5-440e-ba57-08da347f1075
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 01:22:36.7831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WqMy2NA8nE3CL3niMV2KLQklFzbQnKD2szHZxAb9n6/uDBfhK+D+iKkLfbgOkP/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4575
X-Proofpoint-ORIG-GUID: gz3VoLb8-YNJ087DT1H8n7zp8rGeptIj
X-Proofpoint-GUID: gz3VoLb8-YNJ087DT1H8n7zp8rGeptIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_19,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA1LTA5IGF0IDIwOjA0IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIE1vbiwgTWF5IDAyLCAyMDIyIGF0IDExOjA5OjM4UE0gKzAwMDAsIERlbHlhbiBL
cmF0dW5vdiB3cm90ZToNCj4gPiBJbiBvcmRlciB0byBhZGQgYSB2ZXJzaW9uIG9mIGJwZl9wcm9n
X3J1bl9hcnJheSB3aGljaCBhY2Nlc3NlcyB0aGUNCj4gPiBicGZfcHJvZy0+YXV4IG1lbWJlciwg
d2UgbmVlZCBicGZfcHJvZyB0byBiZSBtb3JlIHRoYW4gYSBmb3J3YXJkDQo+ID4gZGVjbGFyYXRp
b24gaW5zaWRlIGJwZi5oLg0KPiA+IA0KPiA+IEdpdmVuIHRoYXQgZmlsdGVyLmggYWxyZWFkeSBp
bmNsdWRlcyBicGYuaCwgdGhpcyBtZXJlbHkgcmVvcmRlcnMNCj4gPiB0aGUgdHlwZSBkZWNsYXJh
dGlvbnMgZm9yIGZpbHRlci5oIHVzZXJzLiBicGYuaCB1c2VycyBub3cgaGF2ZSBhY2Nlc3MgdG8N
Cj4gPiBicGZfcHJvZyBpbnRlcm5hbHMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVseWFu
IEtyYXR1bm92IDxkZWx5YW5rQGZiLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9i
cGYuaCAgICB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBp
bmNsdWRlL2xpbnV4L2ZpbHRlci5oIHwgMzQgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi5oIGIvaW5jbHVk
ZS9saW51eC9icGYuaA0KPiA+IGluZGV4IGJlOTQ4MzNkMzkwYS4uNTdlYzYxOWNmNzI5IDEwMDY0
NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBmLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L2JwZi5oDQo+ID4gQEAgLTUsNiArNSw3IEBADQo+ID4gICNkZWZpbmUgX0xJTlVYX0JQRl9IIDEN
Cj4gPiAgDQo+ID4gICNpbmNsdWRlIDx1YXBpL2xpbnV4L2JwZi5oPg0KPiA+ICsjaW5jbHVkZSA8
dWFwaS9saW51eC9maWx0ZXIuaD4NCj4gDQo+IGJlY2F1c2Ugb2Ygc3RydWN0IHNvY2tfZmlsdGVy
ID8NCj4gUGxzIGZ3ZCBkZWNsYXJlIGl0IGluc3RlYWQuDQoNClllcyBidXQgeW91IGNhbid0IGZv
cndhcmQgZGVjbGFyZSBpdCBpbiB0aGlzIGNvbnRleHQuDQpJdCdzIHVzZWQgYXMgd2l0aGluIERF
Q0xBUkVfRkxFWF9BUlJBWSwgc28gYSBmb3J3YXJkIGRlY2xhcmF0aW9uIGxlYWRzIHRvOg0KDQou
L2luY2x1ZGUvbGludXgvYnBmLmg6MTEwNzo1NjogZXJyb3I6IGFycmF5IHR5cGUgaGFzIGluY29t
cGxldGUgZWxlbWVudCB0eXBlIOKAmHN0cnVjdA0Kc29ja19maWx0ZXLigJkNCiAxMTA3IHwgICAg
ICAgICAgICAgICAgIERFQ0xBUkVfRkxFWF9BUlJBWShzdHJ1Y3Qgc29ja19maWx0ZXIsIGluc25z
KTsNCg0KPiANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPg0KPiA+ICAjaW5jbHVk
ZSA8bGludXgvZmlsZS5oPg0KPiA+IEBAIC0yMiw2ICsyMyw3IEBADQo+ID4gICNpbmNsdWRlIDxs
aW51eC9zY2hlZC9tbS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvcGVyY3B1LXJlZmNvdW50Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zdGRk
ZWYuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2JwZnB0ci5oPg0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvYnRmLmg+DQo+ID4gIA0KPiA+IEBAIC0xMDY4LDYgKzEwNzAsNDAgQEAgc3RydWN0IGJwZl9w
cm9nX2F1eCB7DQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+ICANCj4gPiArc3RydWN0IGJwZl9wcm9n
IHsNCj4gPiArCXUxNgkJCXBhZ2VzOwkJLyogTnVtYmVyIG9mIGFsbG9jYXRlZCBwYWdlcyAqLw0K
PiA+ICsJdTE2CQkJaml0ZWQ6MSwJLyogSXMgb3VyIGZpbHRlciBKSVQnZWQ/ICovDQo+ID4gKwkJ
CQlqaXRfcmVxdWVzdGVkOjEsLyogYXJjaHMgbmVlZCB0byBKSVQgdGhlIHByb2cgKi8NCj4gPiAr
CQkJCWdwbF9jb21wYXRpYmxlOjEsIC8qIElzIGZpbHRlciBHUEwgY29tcGF0aWJsZT8gKi8NCj4g
PiArCQkJCWNiX2FjY2VzczoxLAkvKiBJcyBjb250cm9sIGJsb2NrIGFjY2Vzc2VkPyAqLw0KPiA+
ICsJCQkJZHN0X25lZWRlZDoxLAkvKiBEbyB3ZSBuZWVkIGRzdCBlbnRyeT8gKi8NCj4gPiArCQkJ
CWJsaW5kaW5nX3JlcXVlc3RlZDoxLCAvKiBuZWVkcyBjb25zdGFudCBibGluZGluZyAqLw0KPiA+
ICsJCQkJYmxpbmRlZDoxLAkvKiBXYXMgYmxpbmRlZCAqLw0KPiA+ICsJCQkJaXNfZnVuYzoxLAkv
KiBwcm9ncmFtIGlzIGEgYnBmIGZ1bmN0aW9uICovDQo+ID4gKwkJCQlrcHJvYmVfb3ZlcnJpZGU6
MSwgLyogRG8gd2Ugb3ZlcnJpZGUgYSBrcHJvYmU/ICovDQo+ID4gKwkJCQloYXNfY2FsbGNoYWlu
X2J1ZjoxLCAvKiBjYWxsY2hhaW4gYnVmZmVyIGFsbG9jYXRlZD8gKi8NCj4gPiArCQkJCWVuZm9y
Y2VfZXhwZWN0ZWRfYXR0YWNoX3R5cGU6MSwgLyogRW5mb3JjZSBleHBlY3RlZF9hdHRhY2hfdHlw
ZSBjaGVja2luZyBhdCBhdHRhY2ggdGltZSAqLw0KPiA+ICsJCQkJY2FsbF9nZXRfc3RhY2s6MSwg
LyogRG8gd2UgY2FsbCBicGZfZ2V0X3N0YWNrKCkgb3IgYnBmX2dldF9zdGFja2lkKCkgKi8NCj4g
PiArCQkJCWNhbGxfZ2V0X2Z1bmNfaXA6MSwgLyogRG8gd2UgY2FsbCBnZXRfZnVuY19pcCgpICov
DQo+ID4gKwkJCQl0c3RhbXBfdHlwZV9hY2Nlc3M6MTsgLyogQWNjZXNzZWQgX19za19idWZmLT50
c3RhbXBfdHlwZSAqLw0KPiA+ICsJZW51bSBicGZfcHJvZ190eXBlCXR5cGU7CQkvKiBUeXBlIG9m
IEJQRiBwcm9ncmFtICovDQo+ID4gKwllbnVtIGJwZl9hdHRhY2hfdHlwZQlleHBlY3RlZF9hdHRh
Y2hfdHlwZTsgLyogRm9yIHNvbWUgcHJvZyB0eXBlcyAqLw0KPiA+ICsJdTMyCQkJbGVuOwkJLyog
TnVtYmVyIG9mIGZpbHRlciBibG9ja3MgKi8NCj4gPiArCXUzMgkJCWppdGVkX2xlbjsJLyogU2l6
ZSBvZiBqaXRlZCBpbnNucyBpbiBieXRlcyAqLw0KPiA+ICsJdTgJCQl0YWdbQlBGX1RBR19TSVpF
XTsNCj4gPiArCXN0cnVjdCBicGZfcHJvZ19zdGF0cyBfX3BlcmNwdSAqc3RhdHM7DQo+ID4gKwlp
bnQgX19wZXJjcHUJCSphY3RpdmU7DQo+ID4gKwl1bnNpZ25lZCBpbnQJCSgqYnBmX2Z1bmMpKGNv
bnN0IHZvaWQgKmN0eCwNCj4gPiArCQkJCQkgICAgY29uc3Qgc3RydWN0IGJwZl9pbnNuICppbnNu
KTsNCj4gPiArCXN0cnVjdCBicGZfcHJvZ19hdXgJKmF1eDsJCS8qIEF1eGlsaWFyeSBmaWVsZHMg
Ki8NCj4gPiArCXN0cnVjdCBzb2NrX2Zwcm9nX2tlcm4JKm9yaWdfcHJvZzsJLyogT3JpZ2luYWwg
QlBGIHByb2dyYW0gKi8NCj4gPiArCS8qIEluc3RydWN0aW9ucyBmb3IgaW50ZXJwcmV0ZXIgKi8N
Cj4gPiArCXVuaW9uIHsNCj4gPiArCQlERUNMQVJFX0ZMRVhfQVJSQVkoc3RydWN0IHNvY2tfZmls
dGVyLCBpbnNucyk7DQo+ID4gKwkJREVDTEFSRV9GTEVYX0FSUkFZKHN0cnVjdCBicGZfaW5zbiwg
aW5zbnNpKTsNCj4gPiArCX07DQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdHJ1Y3QgYnBmX2FycmF5
X2F1eCB7DQo+ID4gIAkvKiBQcm9ncmFtcyB3aXRoIGRpcmVjdCBqdW1wcyBpbnRvIHByb2dyYW1z
IHBhcnQgb2YgdGhpcyBhcnJheS4gKi8NCj4gPiAgCXN0cnVjdCBsaXN0X2hlYWQgcG9rZV9wcm9n
czsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maWx0ZXIuaCBiL2luY2x1ZGUvbGlu
dXgvZmlsdGVyLmgNCj4gPiBpbmRleCBlZDBjMGZmNDJhZDUuLmQwY2JiMzFiMWI0ZCAxMDA2NDQN
Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZpbHRlci5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51
eC9maWx0ZXIuaA0KPiA+IEBAIC01NTksNDAgKzU1OSw2IEBAIHN0cnVjdCBicGZfcHJvZ19zdGF0
cyB7DQo+ID4gIAlzdHJ1Y3QgdTY0X3N0YXRzX3N5bmMgc3luY3A7DQo+ID4gIH0gX19hbGlnbmVk
KDIgKiBzaXplb2YodTY0KSk7DQo+ID4gIA0KPiA+IC1zdHJ1Y3QgYnBmX3Byb2cgew0KPiA+IC0J
dTE2CQkJcGFnZXM7CQkvKiBOdW1iZXIgb2YgYWxsb2NhdGVkIHBhZ2VzICovDQo+ID4gLQl1MTYJ
CQlqaXRlZDoxLAkvKiBJcyBvdXIgZmlsdGVyIEpJVCdlZD8gKi8NCj4gPiAtCQkJCWppdF9yZXF1
ZXN0ZWQ6MSwvKiBhcmNocyBuZWVkIHRvIEpJVCB0aGUgcHJvZyAqLw0KPiA+IC0JCQkJZ3BsX2Nv
bXBhdGlibGU6MSwgLyogSXMgZmlsdGVyIEdQTCBjb21wYXRpYmxlPyAqLw0KPiA+IC0JCQkJY2Jf
YWNjZXNzOjEsCS8qIElzIGNvbnRyb2wgYmxvY2sgYWNjZXNzZWQ/ICovDQo+ID4gLQkJCQlkc3Rf
bmVlZGVkOjEsCS8qIERvIHdlIG5lZWQgZHN0IGVudHJ5PyAqLw0KPiA+IC0JCQkJYmxpbmRpbmdf
cmVxdWVzdGVkOjEsIC8qIG5lZWRzIGNvbnN0YW50IGJsaW5kaW5nICovDQo+ID4gLQkJCQlibGlu
ZGVkOjEsCS8qIFdhcyBibGluZGVkICovDQo+ID4gLQkJCQlpc19mdW5jOjEsCS8qIHByb2dyYW0g
aXMgYSBicGYgZnVuY3Rpb24gKi8NCj4gPiAtCQkJCWtwcm9iZV9vdmVycmlkZToxLCAvKiBEbyB3
ZSBvdmVycmlkZSBhIGtwcm9iZT8gKi8NCj4gPiAtCQkJCWhhc19jYWxsY2hhaW5fYnVmOjEsIC8q
IGNhbGxjaGFpbiBidWZmZXIgYWxsb2NhdGVkPyAqLw0KPiA+IC0JCQkJZW5mb3JjZV9leHBlY3Rl
ZF9hdHRhY2hfdHlwZToxLCAvKiBFbmZvcmNlIGV4cGVjdGVkX2F0dGFjaF90eXBlIGNoZWNraW5n
IGF0IGF0dGFjaCB0aW1lICovDQo+ID4gLQkJCQljYWxsX2dldF9zdGFjazoxLCAvKiBEbyB3ZSBj
YWxsIGJwZl9nZXRfc3RhY2soKSBvciBicGZfZ2V0X3N0YWNraWQoKSAqLw0KPiA+IC0JCQkJY2Fs
bF9nZXRfZnVuY19pcDoxLCAvKiBEbyB3ZSBjYWxsIGdldF9mdW5jX2lwKCkgKi8NCj4gPiAtCQkJ
CXRzdGFtcF90eXBlX2FjY2VzczoxOyAvKiBBY2Nlc3NlZCBfX3NrX2J1ZmYtPnRzdGFtcF90eXBl
ICovDQo+ID4gLQllbnVtIGJwZl9wcm9nX3R5cGUJdHlwZTsJCS8qIFR5cGUgb2YgQlBGIHByb2dy
YW0gKi8NCj4gPiAtCWVudW0gYnBmX2F0dGFjaF90eXBlCWV4cGVjdGVkX2F0dGFjaF90eXBlOyAv
KiBGb3Igc29tZSBwcm9nIHR5cGVzICovDQo+ID4gLQl1MzIJCQlsZW47CQkvKiBOdW1iZXIgb2Yg
ZmlsdGVyIGJsb2NrcyAqLw0KPiA+IC0JdTMyCQkJaml0ZWRfbGVuOwkvKiBTaXplIG9mIGppdGVk
IGluc25zIGluIGJ5dGVzICovDQo+ID4gLQl1OAkJCXRhZ1tCUEZfVEFHX1NJWkVdOw0KPiA+IC0J
c3RydWN0IGJwZl9wcm9nX3N0YXRzIF9fcGVyY3B1ICpzdGF0czsNCj4gPiAtCWludCBfX3BlcmNw
dQkJKmFjdGl2ZTsNCj4gPiAtCXVuc2lnbmVkIGludAkJKCpicGZfZnVuYykoY29uc3Qgdm9pZCAq
Y3R4LA0KPiA+IC0JCQkJCSAgICBjb25zdCBzdHJ1Y3QgYnBmX2luc24gKmluc24pOw0KPiA+IC0J
c3RydWN0IGJwZl9wcm9nX2F1eAkqYXV4OwkJLyogQXV4aWxpYXJ5IGZpZWxkcyAqLw0KPiA+IC0J
c3RydWN0IHNvY2tfZnByb2dfa2Vybgkqb3JpZ19wcm9nOwkvKiBPcmlnaW5hbCBCUEYgcHJvZ3Jh
bSAqLw0KPiA+IC0JLyogSW5zdHJ1Y3Rpb25zIGZvciBpbnRlcnByZXRlciAqLw0KPiA+IC0JdW5p
b24gew0KPiA+IC0JCURFQ0xBUkVfRkxFWF9BUlJBWShzdHJ1Y3Qgc29ja19maWx0ZXIsIGluc25z
KTsNCj4gPiAtCQlERUNMQVJFX0ZMRVhfQVJSQVkoc3RydWN0IGJwZl9pbnNuLCBpbnNuc2kpOw0K
PiA+IC0JfTsNCj4gPiAtfTsNCj4gPiAtDQo+ID4gIHN0cnVjdCBza19maWx0ZXIgew0KPiA+ICAJ
cmVmY291bnRfdAlyZWZjbnQ7DQo+ID4gIAlzdHJ1Y3QgcmN1X2hlYWQJcmN1Ow0KPiA+IC0tIA0K
PiA+IDIuMzUuMQ0KDQo=
