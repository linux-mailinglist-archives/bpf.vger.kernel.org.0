Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3F60D147
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiJYQHa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiJYQH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 12:07:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2940A183D83
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 09:07:28 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PFTmpG020025
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 16:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=KErBhNXfAwVUTM0Q3+E8pu6mFtRRYeNfYPDA9PrJeRg=;
 b=VtB0HQw9/Vr31tT2sEPPIrMcXmxi5Z2E2/kuL+hlIFWs701mjW2WSezvel41vjfBCc6N
 8e3UjPk9ul71//1XHxkXYDoWDLWRHC6BZbJGGWCGzav9XZTAn00U/7BNQLDc3JnT/Cs9
 CrT1pksMJZpKfSOFGbIHoYm2Ra9O7nbJD1J2aUguzNs5NyhbBDCtJH/WQz/w4NcsYb5h
 GXNuw3Ndpuq2Q4Ny1kkVUgUmw/ksw2BgXGDXLR+RV9TyUjQKpGs/VdFbuXvQtVjtAQp9
 1GOkEQM+aBnSv11IjpgEwNANlv/ozSh4nqghClhkrHinT5xlYIw4GxurkLTNkRMUIbXy SQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kejg8gag6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 16:07:27 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 370598040E2
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 16:07:27 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 25 Oct 2022 04:07:27 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 25 Oct 2022 04:07:26 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 25 Oct 2022 04:07:26 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 25 Oct 2022 04:07:26 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3Fq2g5c2F33j2vKuJEoZZIHmmZyHlQI9R6AbqxF9WXORUzbPX7uyHR3FWZH6MmEslGLaoP6RgWPRwE6l5jT5nTPFB/8AiPw0m5sxI/o+dj8/6/7dktgxS8ue3aV4L3/NKbSAqBmBVxiDxC2QFkZHhTk9+5CvHRg/5P+LgHze4Rg6kXJTIc5CeXmglT9KtSgEGOZDg+0qEH7rAdS8EQNutLMhO4BtlvWCwraHStKfZVpIQOsFsxGbRVhQ1UBDQ6582fwT8hGZxPfnKFXZ2oTPMlr03YO2Em+lQxkkEkGdQ8fmDvp3+h1rDt39o0yQ4i5Jk3XJDeDqKpKGdeukxOIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KErBhNXfAwVUTM0Q3+E8pu6mFtRRYeNfYPDA9PrJeRg=;
 b=ROqqgvMZ1gZYISDwayRL19GXtPK2VxnndyigJ3+25JKF1b8T10wJ939/7pDG52OtR1yHWgfAvdlCmF1Xf7trfpBx+dNv5/wkGkmL5JuF4p5ca64V3QsMS1U58H0A7BE/YV4KUAIpHOGH4/GNxB63qlYWegiO63S+U1EURfMOwXMZaZoCKxNP/cem6m1bCnsSSyov8RwN2UjGXj/IpMWSVOUzcSfukeFHtFzBtySMYs2ZrJTjmJlCv8jUqgCByHRZsfLg3SabOK9p7ioaIdXuOAiq4a7IoUpHYrFcdyfucmPVFgBahHyML4Cr4KtMdmsaHmTh/9y3pPTMOtM1W8rbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB1924.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b3::11)
 by SJ0PR84MB1386.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 16:07:16 +0000
Received: from MW4PR84MB1924.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e4f9:663:bd65:74ca]) by MW4PR84MB1924.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e4f9:663:bd65:74ca%6]) with mapi id 15.20.5723.036; Tue, 25 Oct 2022
 16:07:16 +0000
From:   "Matthews, Isaac" <isaac.matthews@hpe.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "Ndu, Geoffrey" <geoffrey.ndu@hpe.com>
Subject: Possible bug/unintended behaviour with bpf_ima_file_hash()
Thread-Topic: Possible bug/unintended behaviour with bpf_ima_file_hash()
Thread-Index: Adjoi1pNRAKsEMpeSmecVOLeffQIyQ==
Date:   Tue, 25 Oct 2022 16:07:16 +0000
Message-ID: <MW4PR84MB19240C74A992D5085136E50C9A319@MW4PR84MB1924.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB1924:EE_|SJ0PR84MB1386:EE_
x-ms-office365-filtering-correlation-id: 13ed6d18-de2b-4ebb-227c-08dab6a2fcb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZrDcegUv5jJwUx7DfTNdpmbg/M7pgEAEQBMGjuLYhD0PQ26gsqzjETncD8GfnBPdoEzmk1nSDFmnHBQ0z2R1AytMwaZCt88Cfar92wLiDDsiWH6tXWS6Q/WB6zLxnJWd1p2C7B5QSwoL1Mrfyg/ypDBsYU9Jt2O4t9Top7jJk28L+l0++/eMkjmS5bVtf+Osmb4anf5Xpe6EpvH4Dlp2ErFNqhWehE5Yqzy6Pw3JBzNCT4hKr98OVFTbta4Yevvd2CW9sfOBABw6x4RQ+Q2jnc9PW8InmcxIOGL+OtTnZGGyvcS0zqQVcsAmas/rYFXpm8hVXmSbXjDG48gSsXTPXMk5r5CrJc8WyJDWcR4gw0MrtGouHfK0nYSL9kxmkCEEohG44nl12vfo3/iuw5OGZUU+tu/ZSf+6j+wTmEt37D822TKKfSzvScCiBm9dMs3s8DkUvYP7ihQsTd981IWOZ59io/+JW5UxCIhC5dMugt70FQysq8KP6uJvTEhfALOcY77e2pzpVPbFpDtldnhnpxKHxz8lakTw2GFeqlWU4YL8kW/1buPgPvyZsP5j/o0iDMMhrr733C5EIQq5GRUspdcSWbrrzf6vcm2ciuXqUETy91Op9qq7lHkwB5Bq082+PGOyykpBUAOx0ECzMpKv7mfwh8DJH2dl/1lRDP0zCt+fQJ1F1EeGKZSS0KlHs9SBxBWn1DLuXhryLrPs5B8Dj+B46HAWp+raBpNr2Ar6qhnBvFL7+YhD1g7HjNIxE/HAyXVB2Z9vr86Vy5tXhtQdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB1924.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(64756008)(66556008)(52536014)(33656002)(71200400001)(4326008)(66476007)(8676002)(66946007)(9686003)(122000001)(38070700005)(8936002)(6506007)(26005)(86362001)(66446008)(76116006)(41300700001)(316002)(5660300002)(83380400001)(186003)(38100700002)(55016003)(7696005)(6916009)(478600001)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K01kDZN8v9RwY5xy4ryDMwTr+MzAtDLtiSrDoXZbh9Xut91CmP2jqNJMGsek?=
 =?us-ascii?Q?lDkk27PeUY1Dtw922uSUeGtHqwjWI5x/BpkGz9pVh16C0mwD+fmwhqQ5UgqJ?=
 =?us-ascii?Q?SHMfxFUUnh8PG1+1Eo2FC7/CGjba9Oi1pUpUR1TbV6wAQhh3bFiF10DE20lp?=
 =?us-ascii?Q?/EcKLmDZyhSwyknfp4BvAJFHbRhl2BQZgSvJwpmlPV1n6u+KGa10oOYxC8aS?=
 =?us-ascii?Q?Q43IICXxh27W7Ujlomhym3CzCXH+aY34X7WbgpEV/lauPl6W4D0ypIYa2dH7?=
 =?us-ascii?Q?c20bYK3jSqOJrIwLkrtoWPWpKkDyEW1wwnXX8bylgoPken5Eg3BG/44RYTg4?=
 =?us-ascii?Q?K1QdAB9ANEVlFI43tB15y44491VLSF62HBjwDyW/rAdQPTpcDAKK6y3aDZOO?=
 =?us-ascii?Q?G/cRW8s6AwA0oqYDkM6/CU709KuU0yDjvXZC/P4OUR76SvUhjgkwoaM0HYbI?=
 =?us-ascii?Q?AuFPQAqTmoJKybh2y3AXd1ZYlngPFjykno2iXYeKyHYYDFyIlB7uQVK4IR6Y?=
 =?us-ascii?Q?hztRIw84abb9sPQ4Vs0diE5qYpvZ/yYtFmsc3MoZ5pow5B/RJy5HlaGXY6wu?=
 =?us-ascii?Q?t96FyD9ncleEDb/zp2zZUsIGuAQGsF8UMn4NY1MgeR5AN+LVbWkGiThW61vC?=
 =?us-ascii?Q?oIqkixhY+sKuVT6iJA6g/+m+b6UZqEYLgHnUC7XZkqD1YSCrz0NrCnNL1QSm?=
 =?us-ascii?Q?Y/grgBPkoEVJ884AC8vahXQZop/gkgl+Ucp4obdPvJ2xme8UA7I2ovdZBrHR?=
 =?us-ascii?Q?V/Md4OcX60Ti4mnh+eSsxLAqaYIvHeagF7ProOMZP1jCXRAuqVVpfNS87p+l?=
 =?us-ascii?Q?EL5/wsRCTCRYWiBunNwzxWBY/pc7lWToy2bW0nI5yppk2phMa2RkRN57eEQX?=
 =?us-ascii?Q?UtQpZfxbNOpigTPKr9KLsJsaIyt3GuJEs7wEZef0hEiVy5mxJasg3fOnRAXu?=
 =?us-ascii?Q?ZMz87h7JK6cxZF5iigTGhSB+csRTvakog7U52qPUbnzeg3FbC9HxosHE0nsR?=
 =?us-ascii?Q?L7lzehALuaDJmuNr5SS0tWeBT0TzKEfC2NisliUSYrR1L3ivlgq2l5PQQHKH?=
 =?us-ascii?Q?BYKpdEbRmc8x3/HKLemyZ4GeqDBdsMBCQIZNgch4JDP5dK4LkQspnz4lM8NZ?=
 =?us-ascii?Q?N6CxZs+ZOA9KdbnJcfv2w3xXg8R60ffjTQ/Lp+wboSAxPxDWHULW8hABym6j?=
 =?us-ascii?Q?yYOnL3oeY5oWsGubjDuec2f2dF+JwVKV5oI2AVDFvhU2bJUWRsqPCPPjO3cj?=
 =?us-ascii?Q?7MT4PTfT6Q3emkmpiXTBtxZZK4R/Izxpt7MDdoDgaM+BWFPdj3Lg1bb14xjs?=
 =?us-ascii?Q?pt00E/AmFdX9hRCrwc+P9w93Nq3vSpWPy/SIMJTNraqIyr7+r+V5PVj5+oNS?=
 =?us-ascii?Q?qu2ZgWtWAvIh0U5zIdllqbN2IYziRFxI96rJIVHG6i1Vz6KAG347MTmuJ5ZK?=
 =?us-ascii?Q?80fH31wi8b41Z2gjv8M4AtUKnPGtzTTlIKgyPExlZOQLRlj7uWJsuCYQHCo/?=
 =?us-ascii?Q?BmO6NbPQxLHfoL2XYanGtIJA/sohpByx1alYvJ2gGOYMTgZcMde7DcizMm8g?=
 =?us-ascii?Q?ix/MRCVPAIn3I9AbG61Ktt2l9+HO0Lg6vuODbCd/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB1924.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ed6d18-de2b-4ebb-227c-08dab6a2fcb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 16:07:16.6499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CR8RNtstpMAqhvZhwShdHIwLCdaT3Q3f/bxG2R5wNnqzVUvf5lq5zvA60K5M+5AE2n4TP9/Rp/Z4pysgW+hDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1386
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: C5ww4-bDEAZv-U3e6GDEUtVFIPE0ndoI
X-Proofpoint-GUID: C5ww4-bDEAZv-U3e6GDEUtVFIPE0ndoI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_09,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 adultscore=0 mlxlogscore=473 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250091
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using bpf_ima_file_hash() from kernel 6.0.

When using bpf_ima_file_hash() with the lsm.s/file_open hook, a hash of the=
 file is only sometimes returned.  This is because the FMODE_CAN_READ flag =
is set after security_file_open() is already called, and ima_calc_file_hash=
() only checks for FMODE_READ not FMODE_CAN_READ in order to decide if a ne=
w instance needs to be opened. Because of this, if a file passes the FMODE_=
READ check  it will fail to be hashed as FMODE_CAN_READ has not yet been se=
t.

To demonstrate: if the file is opened for write for example, when ima_calc_=
file_hash() is called and the file->f_mode is checked against FMODE_READ, a=
 new file instance is opened with the correct flags and a hash is returned.=
 If the file is opened for read, a new file instance is not returned in ima=
_calc_file_hash() as (!(file->f_mode & FMODE_READ)) is now false. When __ke=
rnel_read() is called as part of ima_calc_file_hash_tfm() it will fail on i=
f (!(file->f_mode & FMODE_CAN_READ)) and so no hash will be returned by bpf=
_ima_file_hash().

If possible could someone please advise me as to whether this is intended b=
ehaviour, and is it possible to either modify the flags with eBPF or to ope=
n a new instance with the correct flags set as IMA does currently. Alternat=
ively, would a better solution be adding a check for FMODE_CAN_READ to ima_=
calc_file_hash()?

Thanks for your help.
