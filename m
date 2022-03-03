Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8FA4CB42F
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 02:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiCCApj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiCCApj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:45:39 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B32F29824
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:44:54 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 222JN1aN016737
        for <bpf@vger.kernel.org>; Wed, 2 Mar 2022 16:44:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qZNcnyVEJQCMSf2gGnPa+Rd+0ae4b6PF5cSSlKia82k=;
 b=exOdMq1mm2zwhBE+4Dg4Est8KmSYqYQWs1dQXPHrae4z7GIbbxRSy9HbrRYu/nmOv3My
 g/JFgfc5+DdHQAmwjT+PwEc/B13dP9s90XqQsBeiAVYAHLWrwGDp54LC/XnK2M3K5ZYm
 nLD1c85dZB+pEFhrbj6MKdY570UtRQmyJrs= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ej6mry61y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 16:44:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auPj72bGfNE6BNY5InSU663ZF4I4Ft1FqAILuWjeu0UKri44cmuHsExmxXHcKNbxcNoGgGxZruNskqlXMycpBaex+EE+5eq61a4dSC3d/MK4iIaNEUGGZqcFGcHekE0PLSc7flnVLd7y6yse3sicjnO7w2hTjws9WfJrl7GUZtWo17yMd59rCTG+YUUw4mL34DYZ6sj7xYOTW+H247E5igLb6aS9vnohHf/VNq7B0Z+es9jZ/IVkxY6RlTTl3MjyjlnmY8RcwsHif5EC54iUIjlMKMrlhGiU6MGMInQ8cVj1tkaWdYyGToRvlfRudJ6MDSIulrM8FgtUUKIVZefaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZNcnyVEJQCMSf2gGnPa+Rd+0ae4b6PF5cSSlKia82k=;
 b=UHXlyIFHVS3DtEEpzBMCbKSZ5KH33q6wGtjCD9VYK1FZWJ+b3Smk/7AaICBX3gwm+rgYfXppJHt2/xzvq7hI87Hdj2SVBbxab+VyF2j8DFl30PVf3P1JUPOiw/i8aJu6TArS6HJKePKNZBypRLAHP672zNniDBa3jGOZndQErY1mId/yC5ctsozEcWwNJDW0PHstNXD2rtarDCczwsnvNFurhhJp1Y+FR9Cw8FlsUuCUXlfAARfCw4rVS91OjD7Jsu+jRcJxYm82Ua7M55xB1hpzZxW1WCsvjGxj5AkHET8rwRd4PFfooDXJT5IedtL7Qn5SZWsQzjw9UJWuJ/ceeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SJ0PR15MB4584.namprd15.prod.outlook.com (2603:10b6:a03:37a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 00:44:51 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 00:44:51 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
Thread-Topic: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
Thread-Index: AQHYLeAK9g0hdIS9FkG6uKp/LdoqtaysoVSAgAAqZ4CAAAOZgIAAA00A
Date:   Thu, 3 Mar 2022 00:44:51 +0000
Message-ID: <0b5a69a0c58f2e8bdb0d55a0fce2ab967540b336.camel@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
         <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
         <364c8325-ea90-f8f6-d95b-09c9b0b4589e@iogearbox.net>
         <06118a1998138424c0aace9cb94d67b31b720a0d.camel@fb.com>
         <CAEf4BzaXHG-m1c6NJaKh=dK=-8tjSy4On329NXrS5+HZuhjF=Q@mail.gmail.com>
In-Reply-To: <CAEf4BzaXHG-m1c6NJaKh=dK=-8tjSy4On329NXrS5+HZuhjF=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dedf7bc-5a86-4cb9-a430-08d9fcaf06e4
x-ms-traffictypediagnostic: SJ0PR15MB4584:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4584CCA9FECA275DF769E3FFC1049@SJ0PR15MB4584.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uyb4Tcmx5wjai3giEJ6PvHCRPOD5U1u3bzfbRUBip1jp6cKHAcF0/pxmndvqRnrrdHSWNcq2YwxzqYJzGQepTsIEgIy8SoU/QSC8IH6qtz06q4RVzkH6dkeeq0LS/cOUPWvnv3oqoREU2nygGXFhw6By+UQwGQaiaDFqQDmHHMfeTP81KsnNiwdyHCT5pgK9U9trVKQUsEUlBZ+yDVWc04pq41/+GHClz0L7oXSVws3iLbKaWKZKAACjWACfkPRIV55NVAw9nQ71sszgqB6BFWSn4hsvNjfbARfX/cjH0x5UuAVkjionMAmEJBl0HwmgtTiKRnfLOt+wDCdgqBfJhl95Oojb50SHoRFwES2akMOxEIdiARxDHlrTwNmKkFF+TpsDIKB+NoJpY5GKAg1320wMu5aQYKjclahgbsLZnY66CU1+iEjgrLHoNUF0dveaArHFOJnY20UPndunHrLs6lAE6ftEHxX8MWpx59tkBSZjb7AC9Y4zUbu5I3DAXNKpA+nBnQEbJ9jczzIbYefwvs1hjQOtqfi5HXJKpDjHmxj6jZY3RHnSjr9dlmSSAMNDuZlFmscjqb7jjhsCXa+CXiO9gPYeQ0/xVkqegdzbj9hT3RWbMTS9nDRG2535VMv6ue82dV9HLuHnDce//IkqVhXI5WfBMWVfZE6MCQ1O/p6GHqhHhB/g//ZdlDonJP8jYaqnHrjpBqtPL9o4F8iNYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66946007)(76116006)(8676002)(4326008)(66476007)(66556008)(6506007)(64756008)(66446008)(316002)(6486002)(8936002)(508600001)(71200400001)(36756003)(54906003)(6916009)(38070700005)(186003)(122000001)(38100700002)(6512007)(86362001)(2616005)(558084003)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am93dkJrNDRoNEtuMEVueGFCK1J2RkhISEJMcWtKUVRNOE1MS3gxRTV4WGRJ?=
 =?utf-8?B?Rlg5OXM3NTl2MHhjMVlPeGEvNWM4YVMyTkRVQ2lEMHhLb2Npd0VzS2VaOFo3?=
 =?utf-8?B?VmlGRGcyYXNVYnMxMkRCNkdJMVR5aDYrM2gva3J6aGtnODRJeHFiVmV5RmNs?=
 =?utf-8?B?Q3ZRMU5ETjBJeXZCS1U5Z1pkZ0lYbFZYb3dxUncwcnBzMDFsd0ZyYzlGL3J4?=
 =?utf-8?B?czNDR3V4MEI3cGdtT1NWMGIzdllxR0ZjOG8yaVFEekgyYW9kclJNZVJxL2pz?=
 =?utf-8?B?eU52S0E2UGt6WWJYUzBpMkFrMXkvZzRzSVE0UnpQY21aU2VWVHhnQ1BDZGxE?=
 =?utf-8?B?cUlKWStodUFyYTFnQlJuRkpyVDVMVHlsVWZzazBxZm1wR0JtRkovNjYwRTZl?=
 =?utf-8?B?M1FlWEp5WWRKR0Y1MWNZdmp2MVVRbG9jNFBkTll2UGZSanBvVmR6TFkwVGNu?=
 =?utf-8?B?czRRQjNoUjVLTENNTHMzMEFNYnJLYlNydDlSS1VXUEVwblFwTlNrc1RvTWRm?=
 =?utf-8?B?MVRCc1Y4QTRBazJ2U3kyQmlNMUxnSSttQkVFOHBEZWFSRnBpeStoaFdacXhx?=
 =?utf-8?B?L0ZQUWtTd0k5YUFudTd0V0xRR0N3REpUU1VOdXJOU1U0VXdidnNqZVdScXhZ?=
 =?utf-8?B?Rlg0aGljb1NLTlF4TGtDQlZBRW1tcVRKUjB3YTl3WVlEYzh1bkQwbTNiWW9n?=
 =?utf-8?B?NFdabEFhNWptakZhdVhma3VrVHMwYnljNUl1UWphQ0t2OWc1N2I2NlJyWGVH?=
 =?utf-8?B?azZPTjFBNUF5MHE1MEt3TU1sNnZYUzV1MXE5dkhaZnVqcm82RHhXelhZUTl6?=
 =?utf-8?B?VTFLd1dlRTBBRmtnYjdoTVhLb0E5T28vU0RiMlQ5bnRWL0N3bFlhSHZFeEwv?=
 =?utf-8?B?MU93Mm9iby96eGhnQ1J3dnlSRVE0aWtRSlVzdm1OVUIxaFd6L3pLV3lXcDJM?=
 =?utf-8?B?T0FsTHZQRDhrTW5mdkJyOFZVcFdYRUY3eFJaNGx1RlJrSWMyZ2ZLRlJrelhw?=
 =?utf-8?B?UUJOL1N2LzBZWWIwaXM3VmJHdTV6ZVhFTEdjeUN1ZlQ3eWpsZ2NTeHRzVEsy?=
 =?utf-8?B?cENEcVp2S3NFVzBYN0lzNU8zQlVJbXkyaEd0UjZYWVBKVTYrSVNhQzVLWTdP?=
 =?utf-8?B?ZXRmSkVLSThzbUVTZWNBQTZxSXBKQXhuQ1o4NGErb2FUQ3F3b055RVBDSVNr?=
 =?utf-8?B?QVQrOS9vUE1BdGpyNmdJVFFwVk83dXd3TVI5WXY1ZS8yUnhIZUY0V2tlZzN3?=
 =?utf-8?B?ejVTN1VmTmlGSGhnekhDRkVsUzIxL3hYTnpEZGhvM1RUZHNFVEpzVVZuR3N5?=
 =?utf-8?B?UG5EZDVJcHVBWkcrZFhFblBzTExib2JIVHl4T0tNUWtMK0pYbmxOeWJ4aHFJ?=
 =?utf-8?B?OThZTGZzMnBkZjArR01QTWQrVHg0S0M2UkQydmpkcWQwdmtwMUpVenV6ZUdJ?=
 =?utf-8?B?RnhWcWtIME42ZFBnRk94cjRjNzBLb1ZUVEdzSUNza0FkRmFhWGxzK2VDVm9I?=
 =?utf-8?B?Wk5CNTF5cTYwRDNVdS9ERjhyRE9wZjVCL21mZnYxNlREWm5nckIxZkJXNFVs?=
 =?utf-8?B?U0Z5MkZ5ZEZuUEhEL0Y0b1g1V0Nta3FJd0FYYWh3K1BOc1JnVHBrbDhiVGJ1?=
 =?utf-8?B?SERuN0orVHZHclI4a1RnUklWb0M3T1BZeGx0NmdoVElvOUgxWDNTcWFjcGh0?=
 =?utf-8?B?eWp0R2x3MDVuUmhQMG9wVjRISmtwUytmaHp2TE5FaFJRRCtGWjM4SG0xa09G?=
 =?utf-8?B?dVc5SldZWDRiQkFoL3FJdEdCVTAyZlRvVXMwNWlvWVlQYUZKK0w3bUdqcXJ5?=
 =?utf-8?B?cUE3bEFHQ3llREo5TnNLcENVM0JBaDV0dksxVWp4YTdHKzA5YkVoYlU5R25x?=
 =?utf-8?B?OStnd0c5V25ZbXpObVY4cU0zelU1RHJHb1k5UHdXRkFKak1IRDZXcUNyZk5C?=
 =?utf-8?B?TEp2NlZSUWYxU0JhaG5FakZGMjM2YzBDbEZENHhlMi85OVVzaTZleXNEbjIx?=
 =?utf-8?B?ZU1QUUY4TG4wcFBaYytNM05IMjJ0UnAxRFFaQ0tGNHZ0ZmJBSWk2ZllYYTYr?=
 =?utf-8?B?RmNJeWM3U3pqY0hVaFhWeWg1REJOWGxWV25vNlc3YS9Za2ZyaWRlSjEwdzVt?=
 =?utf-8?B?Ym90eGRkMlV4SThlSW9oTml3NUhBRUxOdkNQdzQzRDhUdmFWSkxrSU1TL21I?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3465C0E525BAA041AE56057C5E47ED36@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dedf7bc-5a86-4cb9-a430-08d9fcaf06e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 00:44:51.3822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTSowH8YFiXLcUxB4kVOKbjkkm8EAROAwOyH/OA0X9FOZClBD1XSJrlVAu8phW67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4584
X-Proofpoint-ORIG-GUID: uNYkIcKPV-CWs6FqaAVYyct7bhP5avLm
X-Proofpoint-GUID: uNYkIcKPV-CWs6FqaAVYyct7bhP5avLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=580
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030001
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTAyIGF0IDE2OjI4IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IFBsZWFzZSBob2xkIG9mZiB1bnRpbCB5b3UgZ2V0IHJldmlldyBmZWVkYmFjaw0KDQpIYXBw
eSB0byB3YWl0LCBJIGRpc2NvdmVyZWQgc29tZSBmdW5jdGlvbmFsIGlzc3VlcyBpbiB0aGUgdGVz
dCBvbmNlIHJvZGF0YSBhbmQNCmJwZiBoZWxwZXJzIGFyZSBpbnZvbHZlZCBpbiB0aGUgbGliLiBJ
IGhhdmUgc29tZSBkZWJ1Z2dpbmcgdG8gZG8gYW55d2F5Lg0K
